FactoryGirl.define do
  factory :subscription, :class => Spree::Subscription do
    # associations:
    variant { FactoryGirl.create(:variant, :subscribable => true) }
  end
end
