FactoryGirl.define do
  factory :subscription, :class => Spree::Subscription do
    # associations:
    magazine { FactoryGirl.create(:variant, :subscribable => true) }
    remaining_issues 0
  end

  factory :paid_subscription, :parent => :subscription do
    remaining_issues 5
  end
end
