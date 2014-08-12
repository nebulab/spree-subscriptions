Deface::Override.new(virtual_path: "spree/admin/users/_sidebar",
                     name: "admin_users_subscriptions_tab",
                     insert_bottom: "[data-hook='admin_user_tab_options']",
                     text: %q[<li<%== ' class="active"' if current == :subscriptions %>><%= link_to_with_icon 'calendar', Spree.t(:"admin.user.subscriptions"), subscriptions_admin_user_path(@user) %></li>]
                     )
