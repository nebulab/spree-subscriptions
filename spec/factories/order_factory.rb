FactoryGirl.define do
  factory :order_with_subscription, :parent => :order do
    after_create do |order|
      order.line_items << Factory(:line_item, :order => order,
              :variant => Factory(:variant, :product => Factory(:simple_product), :subscribable => true))
    end
  end
end
