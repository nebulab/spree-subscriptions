require 'spec_helper'

describe "Issue" do
  context "as_admin_user" do
    before do
      user = create(:admin_user, :email => "test@example.com")
      sign_in_as!(user)      
    end

    before(:each) do      
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
          @magazine = create(:simple_product, :subscribable => true).master
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
          page.should have_content("Listing Issues")
          page.should have_content(issue.name)
          page.should_not have_content(other_issue.name)
        end
      end
    end

    context "editing a product issue" do
      before do        
        magazine = create(:simple_product, :subscribable => true).master
        @issue = create(:issue, :magazine => magazine)
        click_link "Products"
        within('table.index tr:nth-child(2)') { click_link "Edit" }
        click_link "Issues"
      end

      it "shoud let access the edit issue page" do
        within('table.index#listing_issues tbody tr:nth-child(1)') { click_link "Edit" }        
        find_field("variant_issues_attributes_0_name").value.should == @issue.name
      end

      it "should let update an issue" do
        within('table.index#listing_issues tbody tr:nth-child(1)') { click_link "Edit" }
        fill_in "Name", :with => "Magazine issue number 4"
        click_button "Update"
        page.should have_content "issue_updated"
        find_field("variant_issues_attributes_0_name").value.should == "Magazine issue number 4"
      end

    end   
  end
end
