module Spree
  Variant.class_eval do
    attr_accessible :subscribable, :issues_attributes

    has_many :issues, :dependent => :destroy, :foreign_key => "magazine_id"
    has_many :subscriptions, :foreign_key => "magazine_id"

    accepts_nested_attributes_for :issues
    
    scope :subscribable, where(:subscribable => true)

  end
end