class Spree::ShippedIssue < ActiveRecord::Base
  belongs_to :issue, autosave: true, counter_cache: true
  belongs_to :subscription, autosave: true
  has_one :magazine_issue, through: :issue
end
