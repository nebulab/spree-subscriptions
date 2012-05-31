FactoryGirl.define do
  factory :issue, :class => Spree::Issue do
    # associations:
    variant
    name "Issue number 4"
  end
end
