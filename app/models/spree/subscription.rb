class Spree::Subscription < ActiveRecord::Base
  attr_accessible :email, :variant_id, :remaining_issues, :ship_address, :ship_address_attributes

  belongs_to :variant
  belongs_to :ship_address, :foreign_key => 'ship_address_id', :class_name => 'Spree::Address'
  has_many :shipped_issues

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
