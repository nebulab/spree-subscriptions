class AddShippedIssueCounterCacheColumn < ActiveRecord::Migration
  def up
    add_column :spree_issues, :shipped_issues_count, :integer, default: 0

    Spree::Issue.reset_column_information
    Spree::Issue.all.each do |issue|
      Spree::Issue.reset_counters issue.id, :shipped_issues
    end
  end

  def down
    remove_column :spree_issues, :shipped_issues_count
  end
end
