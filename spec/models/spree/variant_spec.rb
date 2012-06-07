require 'spec_helper'

describe Spree::Variant do
  let(:variant) { Factory(:subscribable_variant) }  

  it "should respond to issues_number" do
    variant.should respond_to :issues_number
  end
end
