class CreateSpreeIssues < ActiveRecord::Migration
  def change
    create_table :spree_issues do |t|
      t.references :product
      t.references :variant
      t.string :name
      t.date :published_at

      t.timestamps
    end
    add_index :spree_issues, :product_id
    add_index :spree_issues, :variant_id
  end
end
