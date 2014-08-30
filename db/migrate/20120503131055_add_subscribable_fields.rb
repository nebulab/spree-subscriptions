class AddSubscribableFields < ActiveRecord::Migration
  def change
    add_column :spree_products, :subscribable, :boolean, default: false
    add_column :spree_variants, :issues_number, :integer
  end
end
