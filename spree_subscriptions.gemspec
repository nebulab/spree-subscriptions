# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_subscriptions'
  s.version     = '3.0.0'
  s.summary     = 'A spree extension to manage recurring subscriptions'
  s.description = """
      This spree extension lets an ecommerce owner manage subscriptions bought by
      users as a predetermined number of issues.
  """
  s.required_ruby_version = '>= 2.1'

  s.author    = 'NebuLab'
  s.email     = 'info@nebulab.it'
  s.homepage  = 'http://nebulab.it'

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree', '~> 3.0'
  s.add_dependency 'prawn', '~> 0.12.0'
  s.add_dependency 'prawn-labels', '~> 0.11.3'

  s.add_development_dependency 'capybara', '2.2.1'
  s.add_development_dependency 'rspec-rails',  '~> 2.14'
  s.add_development_dependency 'factory_girl', '~> 4.4'
  s.add_development_dependency 'poltergeist', '~> 1.6'
  s.add_development_dependency 'database_cleaner', '~> 1.2'
  s.add_development_dependency 'email_spec', '~> 1.5.0'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'sass-rails', '~> 4.0'
  s.add_development_dependency 'coffee-rails', '~> 4.0'
  s.add_development_dependency 'coveralls', '~> 0.7'
end
