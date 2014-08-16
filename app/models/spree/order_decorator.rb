module Spree
  Order.class_eval do
    def create_subscriptions
      line_items.each do |line_item|
        if line_item.variant.subscribable?
          Subscription.subscribe!(
            email: self.email, 
            ship_address: self.ship_address,
            magazine: line_item.variant.product,
            remaining_issues: line_item.variant.issues_number
          )
        end
      end
    end
  end
end
