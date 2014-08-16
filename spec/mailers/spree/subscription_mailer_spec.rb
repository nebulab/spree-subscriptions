require "spec_helper"

describe Spree::SubscriptionMailer do
  let(:subscription) { mock_model(Spree::Subscription, email: 'subsriber@fake.web') }

  context "subscription ended" do
    let(:email) { Spree::SubscriptionMailer.subscription_ended_email(subscription) }

    it "should sent to subscription email" do
      email.to.should == [subscription.email]
    end

    it "should have proper subject" do
      email.subject.should == Spree.t(:subscription_ended)
    end
  end

  context "subscription ending" do
    let(:email) { Spree::SubscriptionMailer.subscription_ending_email(subscription) }

    it "should sent to subscription email" do
      email.to.should == [subscription.email]
    end

    it "should have proper subject" do
      email.subject.should == Spree.t(:subscription_ending)
    end
  end
end