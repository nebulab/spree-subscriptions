require 'spec_helper'

describe "Subscription" do
  context "as_admin_user" do
    before(:each) do
      visit spree.admin_path
    end

    context "listing subscriptions" do
      context "sorting" do
        # sort by subscription fields
      end
    end

    context "searching subscriptions" do
      # search by some fields
    end

    context "create a new subscription" do
      before(:each) do
        create(:product, :name => 'sport magazine', :available_on => '2011-01-06 18:21:13:', :subscribable => true)
        create(:product, :name => 'web magazine', :available_on => '2011-01-06 18:21:13:', :subscribable => true)
        create(:product, :name => 'the book', :available_on => '2011-01-06 18:21:13:')
        click_link "Subscriptions"
        click_link "admin_new_subscription"
      end

      it "allow admin to go to the new subscription page" do
        within('#new_subscription') do  
          page.should have_content('Variant')
          page.should have_content('Start date')
          page.should have_content('End date')
        end
      end

      it "should allow admin to select subscribable variants only" do
        # this is an hack. The following line does not work!!
        # page.has_no_select?('Variant', :with_options => ['the book'])
        page.should have_xpath("//*[@id='subscription_variant_id']/option", :count => 2)
      end

      it "allow admin to create a new subscription" do
        select "web magazine", :from => "Variant"
        click_button "Create"
        page.should have_content("successfully created!")
        within('table#listing_subscriptions tbody tr:nth-child(1)') { click_link("Edit") } 
        # hack. The following line does not work
        # page.has_select?('Variant', :selected => "sport magazine")
        find_field('Variant').find('option[selected]').text.should == "web magazine"
      end
    end

    context "edit a subscription" do
      before(:each) do
        create(:product, :name => 'sport magazine', :available_on => '2011-01-06 18:21:13:', :subscribable => true)
        create(:product, :name => 'web magazine', :available_on => '2011-01-06 18:21:13:', :subscribable => true)
        create(:subscription)
        click_link "Subscriptions"
      end

      it "should have a link to edit subscribtion" do
        within('table#listing_subscriptions tbody tr:nth-child(1)') { page.should have_content("Edit") } 
      end

      it "should allow to change some fields" do
        within('table#listing_subscriptions tbody tr:nth-child(1)') { click_link("Edit") }
        select "web magazine", :from => "Variant"
        click_button "Update"
        page.should have_content("successfully updated!")
        within('table#listing_subscriptions tbody tr:nth-child(1)') { click_link("Edit") }
        find_field('Variant').find('option[selected]').text.should == "web magazine"
      end

    end
  end
end
