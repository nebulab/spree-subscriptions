def add_to_cart(name, variant=nil)
  visit spree.root_path
  click_link name
  # in the product page
  choose variant if variant
  click_button "add-to-cart-button"
end

def complete_checkout_with_login(email, password)
  begin_checkout
  login_step(email, password)
  address_step
  delivery_step
  payment_step
  confirm_step
end

def complete_checkout_with_guest(email)
  begin_checkout
  guest_step(email)
  address_step
  delivery_step
  payment_step
  confirm_step
end

def begin_checkout
  visit spree.cart_path
  click_button "Checkout"
end

def login_step(email, password)
  click_link 'Login as Existing Customer'
  within("#password-credentials") do
    fill_in "Email", with: email
    fill_in "Password", with: password
  end
  click_button "Login"
end

def guest_step(email)
  within("#guest_checkout") do
    fill_in "Email", with: email
  end
  click_button "Continue"
end

def address_step
  addr = FactoryGirl.attributes_for(:customer_address)
  str_addr = "bill_address"
  within("#billing") do
    fill_in "order_#{str_addr}_attributes_firstname", with: addr[:firstname]
    fill_in "order_#{str_addr}_attributes_lastname", with: addr[:lastname]
    fill_in "order_#{str_addr}_attributes_address1", with: addr[:address1]
    fill_in "order_#{str_addr}_attributes_city", with: addr[:city]
    fill_in "order_#{str_addr}_attributes_phone", with: addr[:phone]
    fill_in "order_#{str_addr}_attributes_zipcode", with: addr[:zipcode]

    all("#order_#{str_addr}_attributes_country_id option")[0].select_option
    all("#order_#{str_addr}_attributes_state_id option")[1].select_option

  end
  within("#shipping") do
    check("Use Billing Address")
  end
  click_button "Save and Continue"
end

def delivery_step
  page.should have_content("package from NY Warehouse")
  click_button "Save and Continue"
end

def payment_step
  page.should have_content("Payment Information")
  click_button "Save and Continue"
end

def confirm_step
  page.should have_content("Your order has been processed successfully")
end

def complete_payment
  order = Spree::Order.where(user_id: Spree.user_class.where(email: "johnny@rocket.com").first.id).first
  order.payments.first.complete!
end

def complete_guest_payment
  Spree::Order.last.payments.first.complete!
end

def create_existing_subscription_for(email, product, remaining)
  FactoryGirl.create(:subscription,
    email: email,
    magazine: product,
    ship_address: create(:customer_address),
    remaining_issues: remaining
  )
end
