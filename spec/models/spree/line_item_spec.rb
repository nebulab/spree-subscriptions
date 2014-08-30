require 'spec_helper'

describe Spree::LineItem do
  it "tells if it has a subscribable product" do
    line_item = create(:subscribable_line_item)
    line_item.subscribable_product?.should be_true
  end

  it "is invalid if quantity of subscribable product is greater than 1" do
    line_item = build(:subscribable_line_item, quantity: 2)
    line_item.should_not be_valid
  end

  it "is valid if quantity of normal product is greater than 1" do
    line_item = build(:line_item, quantity: 2)
    line_item.should be_valid
  end

  it "can be destroyed setting quantity to 0" do
    line_item = build(:subscribable_line_item, quantity: 0)
    line_item.should be_valid
  end
end
