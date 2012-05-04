class Spree::Subscription < ActiveRecord::Base
  attr_accessible :subscribable, :user, :variant
  
  belongs_to :user
  belongs_to :variant
  
  state_machine :state, :initial => 'pending' do
    event :cancel do
      transition :to => 'canceled', :if => :allow_cancel?
    end

    event :activate do
      transition :to => 'active', :from => 'pending'
    end
  end

  def allow_cancel?
    self.state != 'canceled'
  end

end
