require 'spec_helper'

describe "Subscription" do
  context "as_user" do
    before(:all) do
      reset_spree_preferences do |config|
        config.default_country_id = create(:country).id
      end
      create(:state, :country_id => 1)
      create(:free_shipping_method)
      create(:payment_method)
      create(:user, :email => "johnny@rocket.com", :password => "secter", :password_confirmation => "secret")
      @sport_magazine = FactoryGirl.create(:product, :name => 'sport magazine', :available_on => '2011-01-06 18:21:13:', :subscribable => true).id
      create(:product, :name => 'web magazine', :available_on => '2011-01-06 18:21:13:', :subscribable => true)
      create(:product, :name => 'the book', :available_on => '2011-01-06 18:21:13:')
    end

    context "checking out a subscribable product"
      before(:all) do
      end

      it "should be something" do
        add_to_cart("sport magazine", @sport_magazine)
        complete_checkout
      end
  end
end
