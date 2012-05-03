Deface::Override.new(:virtual_path => "spree/layouts/admin",
                     :name => "subscriptions_admin_tab",
                     :insert_bottom => "[data-hook='admin_tabs']",
                     :text => "<%= tab(:subscriptions) %>")
