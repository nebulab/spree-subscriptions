Deface::Override.new(virtual_path: "spree/orders/_line_item",
                     name: "disable_quantity_if_line_item_subscribable",
                     replace_contents: "[data-hook='cart_item_quantity']",
                     partial: "spree/orders/line_item_quantity")
