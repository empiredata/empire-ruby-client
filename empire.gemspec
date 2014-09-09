Gem::Specification.new do |s|
  s.name        = 'empire'
  s.version     = '0.3.4'
  s.date        = '2014-09-08'
  s.summary     = 'Ruby client for the Empire API'
  s.description = 'Ruby client for the Empire API. Empire is an API for accessing enterprise SaaS services such as Salesforce, Zendesk, Google Apps, etc. Empire provides a uniform, database-like interface to every service that it supports. Empire makes it easy to integrate data from multiple enterprise services into your own enterprise app.'
  s.author      = 'UPSHOT Data, Inc.'
  s.email       = 'hello@empiredata.co'
  s.files       = [
    "lib/empire.rb",
    "lib/exceptions.rb",
    "lib/walkthrough.rb"
  ]
  s.homepage    = 'http://empiredata.co'
  s.license     = 'Apache License, Version 2.0'
  s.required_ruby_version = '>= 1.9.3'

  s.add_runtime_dependency 'httpclient', '~> 2.4'
  s.add_runtime_dependency 'irb-pager', '~> 0.0'

  s.add_development_dependency 'rspec', '~> 3.1'
  s.add_development_dependency 'webmock', '~> 1.18'
end
