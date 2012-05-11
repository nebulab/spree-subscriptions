def add_to_cart(name)
  visit spree.root_path
  click_link name
  # in the product page
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

def begin_checkout
  visit spree.cart_path
  click_link "Checkout"
end

def login_step(email, password)
  within("#password-credentials") do
    fill_in "Email", :with => email 
    fill_in "Password", :with => password
  end
  click_button "Login" 
end

def address_step
  within("#billing") do
    fill_in "Name", :with => "Johnny"
    fill_in "Last Name", :with => "Rocket"
    fill_in "Address", :with => "Sturdust Street"
    fill_in "City", :with => "Nebula"
    fill_in "Phone", :with => "01010101"
    fill_in "Zip", :with => "1111"
    select "United States of Foo", :from => "Country"
    sleep(1)
    #select "Alabama", :from => "order_bill_address_attributes_state_id"
    fill_in "order_bill_address_attributes_state_name", :with => "Galaxy"
  end
  within("#shipping") do
    check("Use Billing Address")
  end
  click_button "Save and Continue"
end

def delivery_step
  page.should have_content("Shipping Method")
  click_button "Save and Continue"
end

def payment_step
  page.should have_content("Payment Information")
  click_button "Save and Continue"
end

def confirm_step
  page.should have_content("Your order has been processed successfully")
end
