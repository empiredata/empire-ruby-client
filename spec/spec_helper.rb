require 'webmock/rspec'

RESPONSE_DESCRIBE_ALL = '{"status": "OK", "name": "salesforce"}'
RESPONSE_DESCRIBE_SALESFORCE = '{"status": "OK", "name": "salesforce", "tables": ["table1"]}'
RESPONSE_DESCRIBE_TABLE = '{"status": "OK", "name": "table1"}'

class Empire
  include WebMock::API

  def setup_mocks
    stub_request(:post, @base_url + "session/create?enduser=#{@enduser}").
      to_return(:body => '{"status": "OK", "sessionkey": "TESTSESSION"}', :status => 200)

    stub_request(:post, @base_url + "services/salesforce/connect").
      to_return(:body => '{"status": "OK"}', :status => 200)

    stub_request(:get, @base_url + "services").
      to_return(:body => RESPONSE_DESCRIBE_ALL, :status => 200)

    stub_request(:get, @base_url + "services/salesforce").
      to_return(:body => RESPONSE_DESCRIBE_SALESFORCE, :status => 200)

    stub_request(:get, @base_url + "services/salesforce/table1").
      to_return(:body => RESPONSE_DESCRIBE_TABLE, :status => 200)

    stub_request(:post, @base_url + "query").
      to_return(:body => File.new('spec/query_response_body.txt'), :status => 200)

    stub_request(:put, /#{@base_url}view\/\w+/).
      to_return(:body => '{"status": "OK"}', :status => 200)

    stub_request(:delete, /#{@base_url}view\/\w+/).
      to_return(:body => '{"status": "OK"}', :status => 200)
  end
end

RSpec.configure do |config|
  # Use color in STDOUT
  config.color = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  config.formatter = :documentation # :progress, :html, :textmate

  # Allow old-style rspec syntax in addition to new-style syntax
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end