require 'spec_helper'

describe "Subscription" do
  context "as_user" do
    before(:each) do
      reset_spree_preferences do |config|
        config.default_country_id = create(:country).id
      end
      create(:free_shipping_method)
      create(:payment_method)
      @product = create(:product, :name => 'sport magazine', :available_on => '2011-01-06 18:21:13:', :subscribable => true, :issues_number => 44)
      @user = create(:user, :email => "johnny@rocket.com", :password => "secret", :password_confirmation => "secret")
    end

    context "checking out a subscribable product" do
      it "should be able to complete checkout with a magazine in the order" do
        visit spree.root_path
        add_to_cart("sport magazine")
        complete_checkout_with_login("johnny@rocket.com", "secret")
        complete_payment
        visit spree.account_path
        page.should have_content "sport magazine"
        page.should have_content "44"
        page.should have_content "Active"
      end
    end

    context "checking out with guest checkout" do
      it "should be able to complete checkout with a magazine in the order" do
        visit spree.root_path
        add_to_cart("sport magazine")
        complete_checkout_with_guest("johnny@rocket.com")
        complete_guest_payment
        sign_in_as!(@user)
        visit spree.account_path
        page.should have_content "sport magazine"
        page.should have_content "44"
        page.should have_content "Active"
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

        it "should not find an active subscription if order is not paid" do
          visit spree.account_path
          page.should_not have_content "sport magazine"
          page.should_not have_content "44"
          page.should_not have_content "Active"
          page.should_not have_content "Johnny Rocket"
        end
        
        context "after order is paid" do
          before do
            complete_payment
          end

          it "should find a pending subscription" do
            visit spree.account_path
            page.should have_content "sport magazine"
            page.should have_content "44"
            page.should have_content "Active"
            page.should have_content "Johnny Rocket"
          end

          it "should find an active subscription" do
            visit spree.account_path
            page.should have_content "sport magazine"
            page.should have_content "Active"
          end
        end
      end
    end

    context "on susequent orders" do
      it "should add issue numbers when renewing" do
        create_existing_subscription_for("johnny@rocket.com", @product, 44)
        visit spree.root_path
        add_to_cart("sport magazine")
        complete_checkout_with_login("johnny@rocket.com", "secret")
        complete_payment
        visit spree.account_path
        page.should have_content "sport magazine"
        page.should have_content "88"
        page.should have_content "Active"
      end
    end
  end
end
