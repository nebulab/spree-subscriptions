Spree::Variant.class_eval do
  attr_accessible :subscribable

  scope :subscribable, where(:subscribable => true)

end
