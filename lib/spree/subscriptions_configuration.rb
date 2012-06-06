class Spree::SubscriptionsConfiguration < Spree::Preferences::Configuration
  preference :use_delayed_job, :boolean, :default => true
end