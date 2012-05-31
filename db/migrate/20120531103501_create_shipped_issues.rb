class CreateShippedIssues < ActiveRecord::Migration
  def change
    create_table :spree_shipped_issues do |t|
      t.references :issue
      t.references :subscription

      t.timestamps
    end
    add_index :spree_shipped_issues, :issue_id
    add_index :spree_shipped_issues, :subscription_id
  end
end
