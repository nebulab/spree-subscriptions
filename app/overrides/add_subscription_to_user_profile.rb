Deface::Override.new(virtual_path: "spree/users/show", 
                     name: "adds_subscription_to_user_profile",
                     insert_after: "[data-hook='account_my_orders']", 
                     partial: "spree/users/subscriptions")
