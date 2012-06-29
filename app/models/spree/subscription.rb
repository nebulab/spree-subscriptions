class Spree::Subscription < ActiveRecord::Base
  attr_accessible :email, :magazine_id, :remaining_issues, :ship_address_attributes, :ship_address

  belongs_to :magazine, :class_name => 'Spree::Product'
  belongs_to :ship_address, :class_name => 'Spree::Address'
  has_many :shipped_issues

  alias_method :shipping_address, :ship_address
  alias_method :shipping_address=, :ship_address=
  accepts_nested_attributes_for :ship_address
  
  validates_with SubscriptionValidator
  
  state_machine :state, :initial => 'active' do
    event :cancel do
      transition :to => 'canceled', :if => :allow_cancel?
    end
  end

  def self.create_for(opts)
    opts.to_options!.assert_valid_keys(:email, :ship_address, :magazine, :remaining_issues)

    existing_magazine = self.where(:email => opts[:email], :magazine_id => opts[:magazine].id).first

    if existing_magazine
      total_remaining_issues = existing_magazine.remaining_issues + opts[:remaining_issues].to_i
      existing_magazine.update_attribute(:remaining_issues, total_remaining_issues)
      existing_magazine.update_attribute(:ship_address_id, opts[:ship_address].id)
      existing_magazine
    else
      self.create(:email => opts[:email], 
        :magazine_id => opts[:magazine].id, 
        :remaining_issues => opts[:remaining_issues],
        :ship_address => opts[:ship_address],
      )
    end
  end

  def ended?
    remaining_issues == 0
  end

  def ending?
    remaining_issues == 1
  end

  def notify_ended!
    if Spree::Subscriptions::Config.use_delayed_job
      Spree::SubscriptionMailer.delay.subscription_ended_email(self).deliver
    else
      Spree::SubscriptionMailer.subscription_ended_email(self).deliver
    end
  end

  def notify_ending!
    if Spree::Subscriptions::Config.use_delayed_job
      Spree::SubscriptionMailer.delay.subscription_ending_email(self).deliver
    else
      Spree::SubscriptionMailer.subscription_ending_email(self).deliver
    end
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
