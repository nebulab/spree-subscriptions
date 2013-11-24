class Spree::Issue < ActiveRecord::Base
  belongs_to :magazine, :class_name => "Spree::Product"
  belongs_to :magazine_issue, :class_name => "Spree::Product"
  has_many :shipped_issues

  attr_accessible :name, :published_at, :shipped_at, :magazine, :magazine_issue_id

  delegate :subscriptions, :to => :magazine

  validates :name,
            :presence => true,
            :unless => "magazine_issue.present?"

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
end
