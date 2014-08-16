require 'spec_helper'

describe Spree::Variant do
  let(:variant) { create(:subscribable_variant) }
  let(:variant_without_issue_number) { create(:subscribable_variant, issues_number: "")}
  let(:base_product_variant) { create(:variant) }

  it "should respond to issues_number" do
    variant.should respond_to :issues_number
  end

  it "should use default value if not specified" do
    variant_without_issue_number.issues_number.should == Spree::Subscriptions::Config.default_issues_number
  end

  it "should respond to subscribable? method" do
    variant.should respond_to :subscribable?
  end

  it "should respond to subscribable? with true" do
    variant.subscribable?.should be_true
  end

  it "should have subscribable to false by default" do
    base_product_variant.subscribable?.should be false
  end

end
