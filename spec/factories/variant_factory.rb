FactoryGirl.define do
  factory :subscribable_variant, :parent => :variant do
    # associations:
    product :subscribable_product
    issues_number 4
  end
end
