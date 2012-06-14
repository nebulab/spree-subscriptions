class Spree::SubscriptionsConfiguration < Spree::Preferences::Configuration
  preference :use_delayed_job, :boolean, :default => true
  preference :default_issues_number, :integer, :default => 12
end