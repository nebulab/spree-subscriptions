class Spree::SubscriptionMailer < ActionMailer::Base
  default from: "from@example.com"

  def subscription_ending_email(subscription)
    @subscribed_by = subscription.email
    mail(:to => @subscribed_by, :subject => t(:subscription_ending))
  end

  def subscription_ended_email(subscription)
    @subscribed_by = subscription.email
    mail(:to => @subscribed_by, :subject => t(:subscription_ended))
  end
end