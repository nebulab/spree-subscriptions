class AddSubscribableToVariant < ActiveRecord::Migration
  def change
    add_column :spree_variants, :subscribable, :boolean
  end
end
