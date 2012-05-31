class CreateSpreeSubscriptions < ActiveRecord::Migration
  def change
    create_table :spree_subscriptions do |t|
      t.references :magazine
      t.references :ship_address
      t.string :email
      t.string :state
      t.integer :remaining_issues
      t.timestamps
    end
  end
end
