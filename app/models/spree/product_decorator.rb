module Spree
  Product.class_eval do
    delegate_belongs_to :master, :subscribable, :subscribable?, :issues_number
    
    attr_accessible :subscribable, :issues_number
  end
end
