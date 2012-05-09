require 'spec_helper'

describe Spree::Variant do
  before(:each) do
    @variant = Factory(:subscribable_variant)
  end

  it "should respond to subscribable? method" do
    @variant.should respond_to :subscribable?
  end

  it "should be subscribable" do
    @variant.subscribable.should == true
  end
end
