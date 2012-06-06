class AddSubscribableToVariant < ActiveRecord::Migration
  def change
    add_column :spree_variants, :subscribable, :boolean
    add_column :spree_variants, :issues_number, :integer
  end
end
