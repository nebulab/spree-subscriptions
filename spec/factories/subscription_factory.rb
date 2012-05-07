FactoryGirl.define do
  factory :subscription, :class => Spree::Subscription do
    # associations:
    user { FactoryGirl.create(:user) }
    variant { FactoryGirl.create(:variant, :subscribable => true) }
  end
end
