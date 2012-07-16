FactoryGirl.define do
  factory :order_with_subscription, :parent => :order do
    after(:create) do |order|
      order.line_items << Factory(:line_item, :order => order,
              :variant => Factory(:subscribable_variant))
    end
  end
end
