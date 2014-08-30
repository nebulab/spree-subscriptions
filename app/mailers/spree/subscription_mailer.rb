module Spree
  class SubscriptionMailer < BaseMailer
    def subscription_ending_email(subscription)
      @subscribed_by = subscription.email
      mail(to: @subscribed_by, subject: Spree.t(:subscription_ending), from: from_address)
    end

    def subscription_ended_email(subscription)
      @subscribed_by = subscription.email
      mail(to: @subscribed_by, subject: Spree.t(:subscription_ended), from: from_address)
    end
  end
end
