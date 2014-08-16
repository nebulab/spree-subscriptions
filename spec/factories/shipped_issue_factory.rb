FactoryGirl.define do
  factory :shipped_issue, class: Spree::ShippedIssue do
    # associations:
    subscription
  end
end