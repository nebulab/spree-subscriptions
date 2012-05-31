FactoryGirl.define do
  factory :subscription, :class => Spree::Subscription do
    # associations:
    magazine { FactoryGirl.create(:variant, :subscribable => true) }
  end
end
