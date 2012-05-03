Deface::Override.new(:virtual_path => "spree/admin/variants/_form", 
                     :name => "adds_subscribable_to_variant",
                     :insert_bottom => "[data-hook='variants']", 
                     :partial => "spree/admin/variants/subscribable")
