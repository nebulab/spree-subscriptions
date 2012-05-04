FactoryGirl.define do
  factory :subscribable_variant, :parent => :variant do
    subscribable true
  end
end
