class AddShippedToSpreeIssue < ActiveRecord::Migration
  def change
    add_column :spree_issues, :shipped_at, :datetime
  end
end
