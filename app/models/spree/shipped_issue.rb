class Spree::ShippedIssue < ActiveRecord::Base
  #belongs_to :issue
  belongs_to :subscription
  
end
