class DefaultRemainingIssuesToZero < ActiveRecord::Migration
  def change
    change_column :spree_subscriptions, :remaining_issues, :integer, default: 0
  end
end
