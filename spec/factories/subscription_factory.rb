FactoryGirl.define do
  factory :subscription, class: Spree::Subscription do
    # associations:
    magazine { FactoryGirl.create(:subscribable_product) }
    ship_address { FactoryGirl.create(:address) }
    remaining_issues 4
    email "johnny@rocket.com"
  end

  factory :paid_subscription, parent: :subscription do
    remaining_issues 5
  end

  factory :ending_subscription, parent: :subscription do
    remaining_issues 2
  end

  factory :ended_subscription, parent: :subscription do
    remaining_issues 0
  end

  factory :customer_address, class: Spree::Address do
    firstname 'Johnny'
    lastname 'Rocket'
    address1 'Sturdust Street'
    city 'Nebula'
    phone '01010101'
    zipcode '11111'
    state_name 'Galaxy'
    country
  end
end
