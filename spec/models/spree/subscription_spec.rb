require 'spec_helper'

describe Spree::Subscription do
  before(:each) do
    @order = Factory(:order_with_subscription)
  end

  context "when order is not completed yet" do
    it "should be associated to an order line item" do
      @order.line_items.first.variant.subscribable.should be_true
    end

    it "should not be created before order completetion" do
      Spree::Subscription.find(:first, :conditions => {:variant_id => @order.line_items.first.variant }).should be_nil
    end
  end

  context "when order is completed" do
    context "when user is not already subscribed" do
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

      it "should have active status if order is paid" do
        # Create a payment
        @order.payments << Factory(:payment, :order => @order, :amount => @order.total)
        # Capture payment
        @order.payments.first.capture!
        # Next state for subscription state machine
        @subscription.activate!
        @subscription.state.should == "active"
      end
    end

    context "when user is already subscribed" do
      before do
        # Create a subscription with same user and variant
        @user = @order.user
        @variant = @order.line_items.first.variant
        Spree::Subscription.create(:user => @user, :variant => @variant)
        # Search for the subscription
        @subscription = Spree::Subscription.find(:first, :conditions => {:variant_id => @order.line_items.first.variant })
      end

      context "before order completion" do
        it "should already exists" do
          @subscription.should_not be_nil
        end
      end

      context "after order completion" do
        before do
          # Field required to complete the order 
          @order.bill_address = Factory(:address)
          @order.ship_address = Factory(:address)
          Factory(:inventory_unit, :order => @order, :state => 'shipped')
          # Finalize order
          @order.finalize!
          # Search for all the subscriptions with current user and variant
          @subscriptions = Spree::Subscription.find(:all, :conditions => {:variant_id => @order.line_items.first.variant })
        end

        it "should not have to be created as new" do
          @subscriptions.count.should == 1
        end

        context "when it is already active"
          it "should not have pending state if subscribtion is already active"
          it "should be renewed on payment completion if already exists"
      end
    end
  end
end
