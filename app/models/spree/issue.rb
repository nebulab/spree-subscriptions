class Spree::Issue < ActiveRecord::Base
  belongs_to :product
  belongs_to :variant
  attr_accessible :name, :published_at
end
