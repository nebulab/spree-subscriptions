module Spree
  Product.class_eval do
    delegate_belongs_to :master, :subscribable, :subscribable?
    
    attr_accessible :subscribable
  end
end
