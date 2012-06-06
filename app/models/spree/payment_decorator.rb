module Spree
  Payment.class_eval do
    state_machine :initial => 'checkout' do
      after_transition :to => 'completed', :do => :activate_subscriptions!
    end

    def activate_subscriptions!
      self.order.activate_subscriptions
    end
  end
end