require 'spec_helper'

describe Spree::Variant do

  it "should respond to subscribable? method" do
    variant = Factory(:subscribable_variant)
    variant.should respond_to :subscribable?
  end

end
