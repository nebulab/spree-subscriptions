require 'spec_helper'

describe Spree::Variant do
  before(:each) do
    @variant = Factory(:subscribable_variant)
  end

  it "should respond to issues_number" do
    @variant.should respond_to :issues_number
  end
end
