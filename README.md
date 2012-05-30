SpreeSubscriptions
==================

This stuff is work in progress. Please, do not use it unless you don't want to contribute :) .

This extension allow to handle subscribable products with numbers based subscription. This means that you can subscribe for N issues for a subscribable products (eg. magazine). Once a new issue is created and shipped, every subscriptions decrease his remaining issues number. When this number decrease to 1, associated user is notified via email that he has to renew his subscription. When it decrease to 0 subscription become inactive.

Features
--------

- Admin can set the numer of issue that compose a subscription (default => 12)
- Admin can mark products or variants as subscribable
- Admin can create issues in each subscribable items (with ability to associate issue with existing products, useful to link issue with backlog products of the same magazine)
- Admin can view (, print and mark as shipped) the list of subscribed users (which have to receive new issue)
- Keep track of shipped issues for each user subscription
- Send user mail notification when it remains an issue only to be shipped
- Send user mail when subscription expires (no remaining issues)

Installation
============

Add the gem to your Gemfile:

```ruby
gem 'spree_subscription', :git => 'git://github.com/nebulab/spree-subscriptions.git'
```

Run bundle:

```bash
bundle
```

Run the generator and migrate your db:

```bash
rails g spree_subscription:install
rake db:migrate
```


Testing
-------

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

    $ bundle
    $ bundle exec rake test_app
    $ bundle exec rspec spec

Copyright (c) 2012 NebuLab, released under the New BSD License
