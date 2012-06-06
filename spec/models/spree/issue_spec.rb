require 'spec_helper'

describe Spree::Issue do
  it "should be part of a magazine" do
    issue = Factory.build(:issue)
    issue.should respond_to(:magazine)
  end

  it "should have many shipped issues" do
    issue = Factory.build(:issue)
    issue.should respond_to(:shipped_issues)
  end

  it "should be related to a product which is the magazine" do
    issue = Factory.create(:issue)
    issue.magazine.should be_an_instance_of Spree::Product
  end

  it "should not be valid if no magazine issue and no name is specified" do
    issue = Factory.build(:issue, :name => "", :magazine_issue => nil)
    issue.should_not be_valid
  end

  it "should have a name like the name of the magazine issue" do
    issue = Factory.create(:issue, :magazine_issue => Factory.create(:simple_product))
    issue.name.should equal(issue.magazine_issue.name)
  end

  it "should have the name attribute if no magazine issue is present" do
    issue = Factory.create(:issue, :name => "New Issue")
    issue.name.should == "New Issue"
  end

  it "should create a shipped issue when shipping issue" do
    subscription = Factory.create(:paid_subscription)
    issue = Factory.create(:issue, :magazine => subscription.magazine)
    expect{ issue.ship! }.to change(issue.shipped_issues, :count).by(1)
  end
end
