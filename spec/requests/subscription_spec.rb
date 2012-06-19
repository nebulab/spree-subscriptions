require 'spec_helper'

describe "Subscription" do
  context "as_user" do
    before(:each) do
      reset_spree_preferences do |config|
        config.default_country_id = create(:country).id
      end
      create(:free_shipping_method)
      create(:payment_method)
      create(:product, :name => 'sport magazine', :available_on => '2011-01-06 18:21:13:', :subscribable => true, :issues_number => 44)
      create(:user, :email => "johnny@rocket.com", :password => "secret", :password_confirmation => "secret")
    end

    context "checking out a subscribable product" do
      it "should be able to complete checkout with a magazine in the order" do
        visit spree.root_path
        add_to_cart("sport magazine")
        complete_checkout_with_login("johnny@rocket.com", "secret")
        visit spree.account_path
        page.should have_content "sport magazine"
        page.should have_content "Pending"
      end
    end

    context "after order completion" do
      before do
        visit spree.root_path
        add_to_cart("sport magazine")
        complete_checkout_with_login("johnny@rocket.com", "secret")
      end

      context "visiting profile page" do
        it "should find a subscription area" do
          visit spree.account_path
          page.should have_content "My subscriptions"
        end

        it "should find a pending subscription" do
          visit spree.account_path
          page.should have_content "sport magazine"
          page.should have_content "pending"
          page.should have_content "44"
        end
        
        context "after order is paid" do
          it "should find an active subscription" do
            order = Spree::Order.find(:first, :conditions => { :user_id => Spree::User.find(:first, :conditions => { :email => "johnny@rocket.com"}).id })
            order.payments.first.complete!
            visit spree.account_path
            page.should have_content "sport magazine"
            page.should have_content "Active"
          end
        end
      end
    end
  end
end
