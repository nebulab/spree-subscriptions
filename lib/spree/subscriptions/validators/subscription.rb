class SubscriptionValidator < ActiveModel::Validator 
  def validate(record)
    unless record.magazine.subscribable?
      record.errors[:magazine] << 'Should be a subscribable product'
    end
  end
end
