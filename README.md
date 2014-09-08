Empire client for Ruby
======================

Bulding gem
------------

Client requires Ruby 1.9+.

```sh
gem build ./empire-client.gemspec
gem install ./empire-client-0.3.gem
```

Usage
-----

In `irb`, type:

```ruby
require 'empire'

empire = Empire.new 'YOUR_APP_KEY', secrets_yaml: 'empire_service_secrets.yaml'

empire.walkthrough
```

or to quickly test it's working:

```sh
ruby ./example.rb YOUR_APP_KEY empire_service_secrets.yaml
```

where `empire_service_secrets.yaml` was downloaded from [https://login.empiredata.co](https://login.empiredata.co)

Testing
-------

First install the development dependencies:

```sh
gem install rspec webmock
```

You can run the test suite with RSpec:

```sh
rspec
```
