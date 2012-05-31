module Spree
  Order.class_eval do
    def finalize!
      update_attribute(:completed_at, Time.now)
      InventoryUnit.assign_opening_inventory(self)
      # lock any optional adjustments (coupon promotions, etc.)
      adjustments.optional.each { |adjustment| adjustment.update_attribute('locked', true) }
      OrderMailer.confirm_email(self).deliver

      self.state_changes.create({
        :previous_state => 'cart',
        :next_state     => 'complete',
        :name           => 'order' ,
        :user_id        => (User.respond_to?(:current) && User.current.try(:id)) || self.user_id
      }, :without_protection => true)

      create_subscriptions
    end

    def create_subscriptions
      line_items.each do |line_item|
        if line_item.variant.subscribable?
          if !Subscription.find(:first, :conditions => {:email => self.user.email, :magazine_id => line_item.variant.id})
            Subscription.create(:email => self.user.email, :magazine_id => line_item.variant.id)
          end
        end
      end
    end

    def activate_subscriptions
       line_items.each do |line_item|
        if line_item.variant.subscribable?
          subscription = Subscription.find(:first, :conditions => {:email => self.user.email, :magazine_id => line_item.variant.id})
          subscription.activate! if subscription && subscription.state == "pending"
        end
      end
    end
  end
end
