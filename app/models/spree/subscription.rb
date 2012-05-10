class Spree::Subscription < ActiveRecord::Base
  attr_accessible :start_date, :end_date, :email, :variant_id, :ship_address, :ship_address_attributes
  belongs_to :variant

  belongs_to :ship_address, :foreign_key => 'ship_address_id', :class_name => 'Spree::Address'
  alias_method :shipping_address, :ship_address
  alias_method :shipping_address=, :ship_address=
  accepts_nested_attributes_for :ship_address
  
  validates_with SubscriptionValidator
  
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
