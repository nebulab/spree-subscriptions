FactoryGirl.define do
  factory :subscription, :class => Spree::Subscription do
    # associations:
    magazine { FactoryGirl.create(:subscribable_product) }
    ship_address { FactoryGirl.create(:address) }
    remaining_issues 0
  end

  factory :paid_subscription, :parent => :subscription do
    remaining_issues 5
  end
end
