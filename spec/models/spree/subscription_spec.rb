require 'spec_helper'

describe Spree::Subscription do

  before(:each) do
    @order = Factory(:order, :shipping_method => Factory(:shipping_method))
    @order.line_items << Factory(:line_item, :order => @order, 
                                 :variant => Factory(:variant, :product => Factory(:simple_product), :subscribable => true ))
    @order.bill_address = Factory(:address)
    @order.ship_address = Factory(:address)
    @order.state = 'complete'
    @order.completed_at = Time.now
    @order.update!
  end

  # delete this
  it "order line_item is subscribable" do
    @order.line_items.first.variant.subscribable.should be_true
  end

  it "should be created on order completetion" do
    Spree::Subscription.find(:first, :conditions => {:variant_id => @order.line_items.first.variant }).should_not be_nil
  end

  it "should be created with pending status if payment is not completed" do
    pending "test that if order is not paid the subscription is created with pendig status"
  end

  it "should be have active status if order is paid" do
    pending "test that if an order is completed and paid, subscription is active"
  end

  it "should be renewed on payment completion if already exists for that user"
    pending "on payment completion an existing subscription should be renewed"
  end

end
