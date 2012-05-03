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

  it "should be created with pending status if payment is not completed" 

  it "should be have active status if order is paid" 

  it "should be renewed on payment completion if already exists for that user"

end
