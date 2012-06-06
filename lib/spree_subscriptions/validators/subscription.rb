class SubscriptionValidator < ActiveModel::Validator 
  def validate(record) 
    unless Spree::Product.find_by_id(record.magazine_id).subscribable?
      record.errors[:magazine] << 'Should be a subscribable product'
    end
  end
end
