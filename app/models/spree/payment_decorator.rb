Spree::Payment.class_eval do
  def after_complete(payment, transition)
    payment.order.activate_subscriptions
  end
end
