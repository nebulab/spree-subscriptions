Deface::Override.new(virtual_path: "spree/admin/shared/_product_tabs",
                     name: "add_issues_tab",
                     insert_bottom: "[data-hook='admin_product_tabs']",
                     partial: "spree/admin/products/issues",
                     disabled: false)