FactoryGirl.define do
  factory :order_with_subscription, parent: :order do
    after(:create) do |order|
      order.line_items << create(:line_item, order: order, variant: create(:subscribable_variant))
    end
  end
end
