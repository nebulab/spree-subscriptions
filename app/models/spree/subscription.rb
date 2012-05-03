class Spree::Subscription < ActiveRecord::Base
  # attr_accessible :title, :body
  
  belongs_to :user
  belongs_to :variant

end
