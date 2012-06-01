class Spree::ShippedIssue < ActiveRecord::Base
  belongs_to :issue, :autosave => true
  belongs_to :subscription, :autosave => true

  attr_accessible :subscription, :issue
end
