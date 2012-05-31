require 'spec_helper'

describe Spree::Issue do
  it "should have a variant" do
    issue = Factory.build(:issue)
    issue.should respond_to(:variant)
  end
end
