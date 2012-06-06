FactoryGirl.define do
  factory :subscribable_variant, :parent => :variant do
    subscribable true
    issues_number 4
  end
end
