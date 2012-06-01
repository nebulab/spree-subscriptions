FactoryGirl.define do
  factory :issue, :class => Spree::Issue do
    # associations:
    magazine { FactoryGirl.create(:product, :subscribable => true).master }
    name "Issue number 4"
  end
end
