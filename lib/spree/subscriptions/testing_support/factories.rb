require 'factory_girl'

subscriptions_factories_path = File.expand_path("#{File.dirname(__FILE__)}/../../../../spec/factories")
Dir["#{subscriptions_factories_path}/**"].each do |f|
  require File.expand_path(f)
end
