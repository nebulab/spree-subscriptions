require 'spec_helper'

describe Spree::ShippedIssue do

  it "should have a subscription" do
    shipped_issue = build(:shipped_issue)
    shipped_issue.should respond_to(:subscription)
  end

  it "should have an issue" do
    shipped_issue = build(:shipped_issue)
    shipped_issue.should respond_to(:issue)
  end

end
