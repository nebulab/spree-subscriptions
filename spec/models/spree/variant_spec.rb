require 'spec_helper'

describe Spree::Variant do
  let(:variant) { Factory(:subscribable_variant) }
  let(:variant_without_issue_number) { Factory(:subscribable_variant, :issues_number => "")}

  it "should respond to issues_number" do
    variant.should respond_to :issues_number
  end

  it "should use default value if not specified" do
    variant_without_issue_number.issues_number.should == Spree::Subscriptions::Config.default_issues_number
  end
end
