SpreeSubscriptions
==================

This stuff is work in progress. Please, do not use it now but contributions are welcome :) .

This extension allow to handle subscribable products with numbers based subscription. This means that you can subscribe for N issues for a subscribable products (eg. magazine). Once a new issue is created and shipped, every subscriptions decrease his remaining issues number. When this number decrease to 1, associated user is notified via email that he has to renew his subscription. When it decrease to 0 subscription become inactive.

Admin can add new issue and view the list of users which have to receive the new item (printable also).

Admin can choose the issues numbers a user can subscribe to.

Example
=======

Example goes here.

Testing
-------

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

    $ bundle
    $ bundle exec rake test_app
    $ bundle exec rspec spec

Copyright (c) 2012 [name of extension creator], released under the New BSD License
