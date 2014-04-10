Deface::Override.new(:virtual_path => "spree/admin/shared/_menu",
                     :name => "subscriptions_admin_tab",
                     :insert_bottom => "[data-hook='admin_tabs']",
                     :text => "<%= tab(:subscriptions, :icon => 'icon-file') %>")
