class Spree::ShippedIssue < ActiveRecord::Base
  belongs_to :issue, :autosave => true
  belongs_to :subscription, :autosave => true
  has_one :magazine_issue, through: :issue

  #attr_accessible :subscription, :issue
end
