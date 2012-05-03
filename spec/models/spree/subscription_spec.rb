require 'spec_helper'

describe Spree::Subscription do

  before(:each) do
    @order = Factory(:order_with_subscription)
  end

  # delete this
  it "order line_item is subscribable" do
    @order.line_items.first.variant.subscribable.should be_true
  end

  it "should not be created after order completetion" do
    Spree::Subscription.find(:first, :conditions => {:variant_id => @order.line_items.first.variant }).should be_nil
  end

  it "should be created on order completetion"
  
  it "should be created with pending status if payment is not completed" 

  it "should be have active status if order is paid" 

  it "should be renewed on payment completion if already exists for that user"

end
