module Spree
  Order.class_eval do
    def create_subscriptions
      line_items.each do |line_item|
        if line_item.variant.product.subscribable?
          if !Subscription.where(:email => self.email, :magazine_id => line_item.variant.product.id).first            
            Subscription.create(:email => self.email, 
              :magazine_id => line_item.variant.product.id, 
              :remaining_issues => line_item.variant.issues_number, 
              :ship_address => self.ship_address
              )
          end
        end
      end
    end
  end
end
