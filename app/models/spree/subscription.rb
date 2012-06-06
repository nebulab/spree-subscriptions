class Spree::Subscription < ActiveRecord::Base
  attr_accessible :email, :magazine_id, :remaining_issues, :ship_address_attributes

  belongs_to :magazine, :class_name => 'Spree::Product'
  belongs_to :ship_address, :class_name => 'Spree::Address'
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

  def ended?
    remaining_issues == 0
  end

  def ending?
    remaining_issues == 1
  end

  def notify_ended!
    Spree::SubscriptionMailer.subscription_ended_email(self).deliver
  end

  def notify_ending!
    Spree::SubscriptionMailer.subscription_ending_email(self).deliver
  end

  def ship!(issue)
    unless shipped?(issue)
      transaction do
        shipped_issues.create(:issue => issue)
        update_attribute(:remaining_issues, remaining_issues-1)

        notify_ending! if ending?
        notify_ended! if ended?
      end
    end
  end

  def shipped?(issue)
    !shipped_issues.where(:id => issue.id).empty?
  end

  def allow_cancel?
    self.state != 'canceled'
  end

end
