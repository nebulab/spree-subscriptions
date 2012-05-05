module Spree
  Product.class_eval do
    attr_accessible :subscribable
    delegate_belongs_to :master, :subscribable
  end
end
