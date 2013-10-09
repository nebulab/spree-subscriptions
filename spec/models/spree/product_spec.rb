require 'spec_helper'

describe Spree::Product do
  let(:product) { create(:subscribable_product) }
  let(:base_product) { create(:base_product) }

  it "should respond to subscribable method" do
    product.should respond_to :subscribable
  end

  it "should be subscribable" do
    product.subscribable.should be_true
  end

  it "should respond to subscribable? method" do
    product.should respond_to :subscribable?
  end

  it "should respond to subscribable? with true" do
    product.subscribable?.should be_true
  end

  it "should have subscribable to false by default" do
    base_product.subscribable?.should be false
  end
end
