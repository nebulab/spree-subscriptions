FactoryGirl.define do
  factory :issue, :class => Spree::Issue do
    # associations:
    magazine { FactoryGirl.create(:variant, :subscribable => true) }
    name "Issue number 4"
  end
end
