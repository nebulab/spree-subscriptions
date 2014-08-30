Deface::Override.new(virtual_path: "spree/admin/variants/_form", 
                     name: "adds_subscribable_to_variant",
                     insert_bottom: "[data-hook='variants']", 
                     partial: "spree/admin/variants/subscription_fields")

Deface::Override.new(virtual_path: "spree/admin/products/_form", 
                     name: "adds_subscribable_to_product",
                     insert_bottom: "[data-hook='admin_product_form_right']", 
                     partial: "spree/admin/products/subscription_fields")
