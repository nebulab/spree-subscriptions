require 'spec_helper'

describe Spree::ShippedIssue do

  it "should have subscription" do
    shipped_issue = Factory.build(:shipped_issue)
    shipped_issue.should respond_to(:subscription)
  end

end
