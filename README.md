SpreeSubscriptions
==================

[![Build Status](https://secure.travis-ci.org/nebulab/spree-subscriptions.png?branch=master)](http://travis-ci.org/nebulab/spree-subscriptions)
[![Coverage Status](https://coveralls.io/repos/nebulab/spree-subscriptions/badge.png)](https://coveralls.io/r/nebulab/spree-subscriptions)
[![Code Climate](https://codeclimate.com/github/nebulab/spree-subscriptions.png)](https://codeclimate.com/github/nebulab/spree-subscriptions)
[![Gitter chat](https://badges.gitter.im/nebulab/spree-subscriptions.png)](https://gitter.im/nebulab/spree-subscriptions)

This extension allows Spree to handle subscribable products with number-based subscriptions. This means that you can subscribe to N issues for a subscribable product (e.g., magazine). Once a new issue is created and shipped, every subscription decreases its remaining issues number. When this number decreases to 1, the associated user is notified via email that he has to renew his subscription. When it decreases to 0, the subscription becomes inactive.

Features
--------

- Admin can mark products as subscribable
- Admin can set the number of issues that compose a subscription for each product and variant (default: 12)
- Admin can create issues in each subscribable item (with the ability to associate issue with existing products, useful to link issue with backlog products of the same magazine)
- Admin can view, print and mark as shipped the list of subscribed users (which have to receive new issue)
- Keep track of shipped issues for each subscription
- Send mail notification when only one issue remains to be shipped
- Send mail notification when subscription expires (no remaining issues)

Installation
============

Add the gem to your Gemfile:

```ruby
gem 'spree_subscriptions', github: 'nebulab/spree-subscriptions', branch: 'master'
```

Run bundle:

```bash
bundle
```

Run the generate and database migration:

```bash
bundle exec rails g spree:subscriptions:install
rake db:migrate
```

Configure default issues number for subscriptions
-------------------------------------------------

For each subscribable product (and his variants) you can choose the number of issues a user can subscribe to. Default value is 12.
To change this default value you can run from the rails console:

```ruby
Spree::Subscriptions::Config.set(:default_issues_number, 24)
```

Use delayed job for email notifications
---------------------------------------

To use delayed_job to send notification mail just add delayed_job to your
store Gemfile and run from rails console:

```ruby
Spree::Subscriptions::Config.set(:use_delayed_job, true)
```

Testing
-------

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

    $ bundle
    $ bundle exec rake test_app
    $ bundle exec rspec spec

Copyright (c) 2012 NebuLab, released under the New BSD License
