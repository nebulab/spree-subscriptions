FactoryGirl.define do
  factory :subscribable_line_item, parent: :line_item do
    association(:variant, factory: :subscribable_variant)
  end
end