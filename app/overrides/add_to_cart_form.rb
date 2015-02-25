Deface::Override.new(virtual_path: "spree/products/_cart_form",
  name: "use_subscribe_locale_instead_of_add_to_cart",
  replace: "erb[loud]:contains(\"Spree.t(:add_to_cart)\")",
  text: "<%= @product.subscribable? ? Spree.t(:subscribe_call_to_action) : Spree.t(:add_to_cart) %>"
  )

Deface::Override.new(virtual_path: "spree/products/_cart_form",
  name: "hide_number_field_for_subscribable_products",
  replace: "erb[loud]:contains(\"number_field_tag\")",
  partial: "spree/products/cart_form_number_field"
  )
