class CreateSpreeIssues < ActiveRecord::Migration
  def change
    create_table :spree_issues do |t|
      t.references :magazine
      t.references :magazine_issue
      t.string :name
      t.date :published_at

      t.timestamps
    end
    add_index :spree_issues, :magazine_id
    add_index :spree_issues, :magazine_issue_id
  end
end
