require 'spec_helper'

describe Spree::Subscription do

  before(:each) do
    @order = Factory(:order_with_subscription)
  end

  context "when order is not completed yet" do
    it "order line_item is subscribable" do
      @order.line_items.first.variant.subscribable.should be_true
    end

    it "should not be created before order completetion" do
      Spree::Subscription.find(:first, :conditions => {:variant_id => @order.line_items.first.variant }).should be_nil
    end
  end

  context "when order is completed" do

    context "when the user is not already subscribed to variant" do

      before do
        # Field required to complete the order 
        @order.bill_address = Factory(:address)
        @order.ship_address = Factory(:address)
        Factory(:inventory_unit, :order => @order, :state => 'shipped')
        # Finalize order
        @order.finalize!
        # Search for the subscription
        @subscription = Spree::Subscription.find(:first, :conditions => {:variant_id => @order.line_items.first.variant })
      end

      it "should be created on order completetion" do
        @subscription.should_not be_nil
      end 

      it "should be created with pending status if payment is not completed" do
        @subscription.state.should == "pending"
      end

      it "should have active status if order is paid"
    end

    context "when order is already subscribed to variant" do

      it "should not have to be created if already exists"
      it "should not have pending state if subscribtion is active"
      it "should be renewed on payment completion if already exists"
    end

  end


end
