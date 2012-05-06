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
      it "allow admin to go to the new subscription page" do
        click_link "Subscriptions"
        click_link "admin_new_subscription"
        within('#new_subscription') { page.should have_content('Variant')}
      end
    end
  end
end
