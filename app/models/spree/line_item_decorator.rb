module Spree
  LineItem.class_eval do
    validates_numericality_of :quantity, :equal_to => 1, :if => :subscribable_product? 

    def subscribable_product?
      product.subscribable?
    end
  end
end
