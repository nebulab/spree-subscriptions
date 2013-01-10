require 'spec_helper'

describe "Issue" do
  context "as_admin_user" do
    before do
      user = create(:admin_user, :email => "test@example.com")
      sign_in_as!(user)
    end

    before do
      visit spree.admin_path
    end

    context "accessing product issues" do
      context "unsuscribable products" do
        it "should not have issue tab" do
          create(:simple_product)
          click_link "Products"
          within('table.index tr:nth-child(2)') { click_link "Edit" }
          page.should_not have_content("Issues")
        end
      end

      context "subscribable products" do
        before(:each) do
          @magazine = create(:subscribable_product)
          click_link "Products"
          within('table.index tr:nth-child(2)') { click_link "Edit" }
        end

        it "should have issue tab" do
          page.should have_content("Issues")
        end

        it "should let view product issues" do
          issue = create(:issue, :magazine => @magazine)
          other_issue = create(:issue)
          click_link "Issues"
          page.should have_content("Available issues")
          page.should have_content(issue.name)
          page.should_not have_content(other_issue.name)
        end
      end
    end

    context "managing an issue" do
      before do
        @magazine = create(:subscribable_product)
        click_link "Products"
        within('table.index tr:nth-child(2)') { click_link "Edit" }
      end

      context "creating an issue" do
        it "should let access the new issue page" do
          click_link "Issues"
          click_link "New issue"
        end

        it "should create a new issue without associated product" do
          click_link "Issues"
          click_link "New issue"
          fill_in "Name", :with => "Magazine issue number 4"
          click_button "Create"
          within("[data-hook='admin_product_issue_header']") { page.should have_content "Magazine issue number 4" }
        end

        it "should create a new issue with an associated product" do
          @product_issue = create(:simple_product, :name => "Issue number 4")
          click_link "Issues"
          click_link "New issue"
          select "Issue number 4", :from => "Product"
          click_button "Create"
          click_link "Issues"
          within('table.index#listing_issues tbody tr:nth-child(1)') { click_link "Edit" }
          find_field('Product').find('option[selected]').text.should == "Issue number 4"
        end

        it "should not let select subscribable product as associated product" do
          @product_issue = create(:simple_product, :name => "Issue number 4")
          click_link "Issues"
          click_link "New issue"
          page.should have_xpath("//*[@id='issue_magazine_issue_id']/option", :count => 2)
        end
      end

      context "editing a product issue" do
        before do
          @issue = create(:issue, :magazine => @magazine)
          click_link "Issues"
        end

        it "shoud let access the edit issue page" do
          within('table.index#listing_issues tbody tr:nth-child(1)') { click_link "Edit" }
          find_field("issue_name").value.should == @issue.name
        end

        it "should let update an issue" do
          within('table.index#listing_issues tbody tr:nth-child(1)') { click_link "Edit" }
          fill_in "Name", :with => "Magazine issue number 4"
          click_button "Update"
          page.should have_content "Issue updated!"
          page.should have_content "Magazine issue number 4"
        end
      end

      context "showing a product issue" do
        before do
          @issue = create(:issue, :magazine => @magazine)
          @subscription = create(:ending_subscription, :magazine => @magazine)
        end

        it "should display the list of subscribers" do
          click_link "Issues"
          within('table.index#listing_issues tbody tr:nth-child(1)') { click_link @issue.name }
          page.should have_content @subscription.email
        end

        it "should display only users subscribed to that issue" do
          @other_magazine = create(:subscribable_product)
          @other_subscription = create(:ending_subscription, :magazine => @other_magazine, :email => "other@email.com")
          click_link "Issues"
          within('table.index#listing_issues tbody tr:nth-child(1)') { click_link @issue.name }
          page.should_not have_content @other_subscription.email
        end

        it "should display only users that have remaining issues" do
          @other_subscription = create(:ended_subscription, :magazine => @magazine, :email => "other@email.com")
          click_link "Issues"
          within('table.index#listing_issues tbody tr:nth-child(1)') { click_link @issue.name }
          page.should_not have_content @other_subscription.email
        end

        context "shipping an issue" do
          before do
            Spree::Subscriptions::Config.use_delayed_job = false
            (0..5).each { |i| create(:ending_subscription, :magazine => @magazine) }
          end

          it "should show listing as 'subscribed'" do
            click_link "Issues"
            within('table.index#listing_issues tbody tr:nth-child(1)') { click_link @issue.name }
            page.should have_content "Subscribed"
          end

          it "should be markable as shipped" do
            click_link "Issues"
            within('table.index#listing_issues tbody tr:nth-child(1)') { click_link @issue.name }
            click_link "ship"
            page.should have_content "successfully shipped"
          end

          context "after issue is shipped" do
            before do
              @issue.ship!
              (0..5).each { |i| create(:ending_subscription, :magazine => @magazine) }
              click_link "Issues"
              within('table.index#listing_issues tbody tr:nth-child(1)') { click_link @issue.name }
            end

            it "should not see the ship button" do
              page.should_not have_content "ship"
            end

            it "should show listing as 'shipped to'" do
              page.should have_content "Shipped to"
            end

            it "should display the list of user that received the issue" do
              page.should have_selector("table#subscriptions_listing tbody tr", :count =>  @issue.shipped_issues.count)
            end
          end
        end
      end
    end
  end
end