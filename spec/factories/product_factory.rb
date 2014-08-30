FactoryGirl.define do
  factory :subscribable_product, parent: :base_product do
    # associations:
    subscribable true
    issues_number 4
  end
end