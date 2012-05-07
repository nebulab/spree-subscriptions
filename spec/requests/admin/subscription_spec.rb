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
        create(:product, :name => 'magazine', :available_on => '2011-01-06 18:21:13:', :subscribable => true)
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

      it "allow admin to create a new subscription" do
        select "magazine", :from => "Variant"
        click_button "Create"
        page.should have_content("successfully created!")
      end
    end
  end
end
