FactoryGirl.define do
  factory :issue, :class => Spree::Issue do
    # associations:
    magazine { FactoryGirl.create(:product, :subscribable => true).master }
    sequence(:name) {|n| "Issue number #{n}" }
  end
end
