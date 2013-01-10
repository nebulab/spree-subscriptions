# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_subscriptions'
  s.version     = '1.2.0'
  s.summary     = 'A spree extension to manage recurring subscriptions'
  s.description = """
      This spree extension lets an ecommerce owner manage subscriptions bought by
      users as a predetermined number of issues.
  """
  s.required_ruby_version = '>= 1.9.2'

  s.author    = 'NebuLab'
  s.email     = 'info@nebulab.it'
  s.homepage  = 'http://nebulab.it'

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 1.2.3'
  s.add_dependency 'prawn', '~> 0.12.0'
  s.add_dependency 'prawn-labels', '~> 0.11.3'
  s.add_dependency 'spree_auth_devise', '~> 1.2.0'

  s.add_development_dependency 'capybara', '1.0.1'
  s.add_development_dependency 'factory_girl', '~> 3.5.0'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 2.11.0'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'coffee-rails'
end
