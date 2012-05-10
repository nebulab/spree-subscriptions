class SubscriptionValidator < ActiveModel::Validator 
  def validate(record) 
    unless Spree::Variant.find_by_id(record.variant_id).subscribable?
      record.errors[:variant] << 'Should be a subscribable product'
    end
  end
end
