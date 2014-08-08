class Spree::Subscription < ActiveRecord::Base
  belongs_to :magazine, class_name: 'Spree::Product'
  belongs_to :ship_address, class_name: 'Spree::Address'
  has_many :shipped_issues
  has_many :issues, through: :shipped_issues

  alias_method :shipping_address, :ship_address
  alias_method :shipping_address=, :ship_address=
  accepts_nested_attributes_for :ship_address

  validates_with SubscriptionValidator

  scope :eligible_for_shipping, -> { where("remaining_issues >= 1") }
  scope :canceled, -> { where(state: :canceled) }

  state_machine :state, initial: :active do
    event :cancel do
      transition to: :canceled, if: :allow_cancel?
    end
  end

  def self.subscribe!(opts)
    opts.to_options!.assert_valid_keys(:email, :ship_address, :magazine, :remaining_issues)

    existing_subscription = self.where(email: opts[:email], magazine_id: opts[:magazine].id).first

    if existing_subscription
      self.renew_subscription(existing_subscription, opts[:remaining_issues], opts[:ship_address])
    else
      self.new_subscription(opts[:email], opts[:magazine], opts[:remaining_issues], opts[:ship_address])
    end
  end

  def ended?
    remaining_issues == 0
  end

  def ending?
    remaining_issues == 1
  end
  
  def canceled?
    return state.intern == :canceled
  end

  def notify_ended!
    if Spree::Subscriptions::Config.use_delayed_job
      Spree::SubscriptionMailer.delay.subscription_ended_email(self)
    else
      Spree::SubscriptionMailer.subscription_ended_email(self).deliver
    end
  end

  def notify_ending!
    if Spree::Subscriptions::Config.use_delayed_job
      Spree::SubscriptionMailer.delay.subscription_ending_email(self)
    else
      Spree::SubscriptionMailer.subscription_ending_email(self).deliver
    end
  end

  def ship!(issue)
    if !ended? && !shipped?(issue)
      transaction do
        shipped_issues.create(issue: issue)
        update_column(:remaining_issues, remaining_issues-1)

        notify_ending! if ending?
        notify_ended! if ended?
      end
    end
  end

  def unship!(issue)
    if self.shipped?(issue)
      transaction do
        num_of_shipped_issues = shipped_issues.where(issue: issue).size
        shipped_issues.where(issue: issue).destroy_all
        update_column(:remaining_issues, remaining_issues + num_of_shipped_issues)
      end
    end
  end

  def shipped?(issue)
    shipped_issues.where(issue: issue).present?
  end

  def allow_cancel?
    self.state != 'canceled'
  end

  private

  def self.new_subscription(email, magazine, remaining_issues, ship_address)
    self.create do |s|
      s.email            = email
      s.magazine_id      = magazine.id
      s.remaining_issues = remaining_issues
      s.ship_address     = ship_address
    end
  end

  def self.renew_subscription(old_subscription, new_remaining_issues, new_ship_address)
    total_remaining_issues = old_subscription.remaining_issues + new_remaining_issues.to_i
    old_subscription.update_attribute(:remaining_issues, total_remaining_issues)
    old_subscription.update_attribute(:ship_address_id, new_ship_address.id)
    old_subscription
  end
end
