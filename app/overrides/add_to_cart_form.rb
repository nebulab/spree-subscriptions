Deface::Override.new(:virtual_path => "spree/products/_cart_form",
  :name => "use_subscribe_locale_instead_of_add_to_cart",
  :replace => "code[erb-loud]:contains(\"t(:add_to_cart)\")",
  :text => "<%= @product.subscribable? ? t(:subscribe_call_to_action) : t(:add_to_cart) %>"
  )

Deface::Override.new(:virtual_path => "spree/products/_cart_form",
  :name => "hide_number_field_for_subscribable_products",
  :replace => "code[erb-loud]:contains(\"number_field_tag\")",
  :partial => "spree/products/cart_form_number_field"
  )