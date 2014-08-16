class Spree::Issue < ActiveRecord::Base
  belongs_to :magazine, class_name: "Spree::Product"
  belongs_to :magazine_issue, class_name: "Spree::Product"
  has_many :shipped_issues

  delegate :subscriptions, to: :magazine

  validates :name,
            presence: true,
            unless: "magazine_issue.present?"

  def name
    magazine_issue.present? ? magazine_issue.name : read_attribute(:name)
  end

  def ship!
    subscriptions.eligible_for_shipping.each{ |s| s.ship!(self) }
    update_attribute(:shipped_at, Time.now)
  end

  def shipped?
    !shipped_at.nil?
  end
    
  def magazine
    # override getter method to include deleted products, as per https://github.com/radar/paranoia
    Spree::Product.unscoped { super }
  end
  
  def magazine_issue
    # override getter method to include deleted products, as per https://github.com/radar/paranoia
    Spree::Product.unscoped { super }
  end

end
