require 'spec_helper'

describe Spree::Product do
  before(:each) do
    @product = Factory(:simple_product, :subscribable => true)
    @simple_product = Factory(:simple_product)
  end

  it "should respond to subscribable method" do
    @product.should respond_to :subscribable
  end

  it "should be subscribable" do
    @product.subscribable.should be_true
  end

  it "should respond to subscribable? method" do
    @product.should respond_to :subscribable?
  end
  
  it "should respond to subscribable? with true" do
    @product.subscribable?.should be_true
  end

  it "should have subscribable to false by default" do
    @simple_product.subscribable?.should be false
  end 
end
