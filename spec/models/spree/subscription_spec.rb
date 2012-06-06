require 'spec_helper'

describe Spree::Subscription do

  it "should have shipped issues" do
    subscription = Factory.build(:subscription)
    subscription.should respond_to(:shipped_issues)
  end

  context "when shipping subscriptions" do
    let(:subscription) { Factory.create(:paid_subscription) }
    let(:issue) { Factory.create(:issue, :magazine => subscription.magazine) }

    it "should ship issues inside a transaction" do
      subscription.should_receive :transaction
      subscription.ship!(issue)
    end

    it "should not reship an issue already shipped" do
      subscription.ship!(issue)
      expect{ subscription.ship!(issue) }.not_to change(subscription.shipped_issues, :count)
    end

    it "should have a method to know if it has been shipped" do
      subscription.shipped?(issue).should be_false
      subscription.ship!(issue)
      subscription.shipped?(issue).should be_true
    end
  end

  context "when a subscription is ending" do
    let(:subscription) { Factory.create(:ending_subscription) }
    let(:issue) { Factory.create(:issue, :magazine => subscription.magazine) }

    before(:each) do
      ActionMailer::Base.deliveries = []
    end

    it "should send an email when the subscription is left with one issue" do
      expect{ subscription.ship!(issue) }.to change(ActionMailer::Base.deliveries, :count).by(1)
    end

    it "should send an email when the subscription is left with zero issues" do
      expect{ subscription.ship!(issue) }.to change(ActionMailer::Base.deliveries, :count).by(1)
    end

    it "should not resend email when the subscription is already at zero issues" do
      subscription.stub(:shipped?).and_return(true)
      expect{ subscription.ship!(issue) }.not_to change(ActionMailer::Base.deliveries, :count)
    end
  end

  context "when adding a subscription" do
    it "should be valid if product is subscribable" do
      subscription = Factory.build(:subscription, :magazine => Factory(:subscribable_product))
      subscription.should be_valid
    end
    
    it "should not be valid if product is not subscribable" do
      subscription = Factory.build(:subscription, :magazine => Factory(:simple_product))
      subscription.should_not be_valid
    end
  end

  context "during an order" do
    before(:each) do
      @order = Factory(:order_with_subscription)
    end

    context "when order is not completed yet" do
      it "should be associated to an order line item" do
        @order.line_items.first.variant.product.subscribable.should be_true
      end

      it "should not be created before order completetion" do
        Spree::Subscription.find(:first, :conditions => {:magazine_id => @order.line_items.first.variant.product }).should be_nil
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
          @subscription = Spree::Subscription.find(:first, :conditions => {:magazine_id => @order.line_items.first.variant.product })
        end

        it "should be created on order completetion" do
          @subscription.should_not be_nil
        end 

        it "should be created with pending status if payment is not completed" do
          @subscription.state.should == "pending"
        end

        it "should have active status if order is paid" do
          @order.payments << Factory(:payment, :order => @order, :amount => @order.total)
          # Capture payment
          @order.payments.first.capture!
          Spree::Subscription.find(:first, :conditions => {:email => @order.user.email, :magazine_id => @order.line_items.first.variant.product.id}).state.should == "active"
        end
      end

      context "when user is already subscribed" do
        before do
          # Create a subscription with same user and variant
          @user = @order.user
          @product = @order.line_items.first.variant.product
          Spree::Subscription.create(:email => @user.email, :magazine_id => @product)
          # Search for the subscription
          @subscription = Spree::Subscription.find(:first, :conditions => {:magazine_id => @order.line_items.first.variant.product })
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
            @subscriptions = Spree::Subscription.find(:all, :conditions => {:magazine_id => @order.line_items.first.variant.product })
          end

          it "should not have to be created as new" do
            @subscriptions.count.should == 1
          end

          context "when it is already active"
            #it "should not have pending state if subscription is already active"
            #it "should be renewed on payment completion if already exists"
        end
      end
    end
  end
end
