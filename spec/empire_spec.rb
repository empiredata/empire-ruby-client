require 'webmock/rspec'

require 'spec_helper'
require_relative '../lib/empire'

describe Empire do
  before(:each) do
    @empire = Empire.new 'MOCK_USER', enduser: 'MOCK_ENDUSER'
    @empire.setup_mocks
  end

  it "connects to services" do
    sf_data = {
      "access_token" => "MOCK_ACCESS_TOKEN",
      "client_id" => "MOCK_CLIENT",
      "refresh_token" => "MOCK_REFRESH_TOKEN",
      "endpoint" => "https://na15.salesforce.com"
    }

    @empire.connect('salesforce', sf_data)

    a_request(:post, @empire.base_url + "services/salesforce/connect").
      with(:body => sf_data.to_json).should have_been_made.once
  end

  describe ".describe" do
    it "describes all services" do
      services_data = @empire.describe
      services_data.should eq(JSON.parse RESPONSE_DESCRIBE_ALL)
    end

    it "describes a service" do
      service_data = @empire.describe 'salesforce'
      service_data.should eq(JSON.parse RESPONSE_DESCRIBE_SALESFORCE)
    end

    it "describes a table" do
      table_data = @empire.describe 'salesforce', 'table1'
      table_data.should eq(JSON.parse RESPONSE_DESCRIBE_TABLE)
    end

    it "doesn't describe a table without a service" do
      expect {
        table_data = @empire.describe nil, 'table1'
      }.to raise_error(Empire::MissingServiceError)
    end

    it "handles failure gracefully" do
      stub_request(:get, @empire.base_url + "services/salesforce/table1").
        to_return(:body => '{"error": "Something is broken"}', :status => 500)

      expect {
        table_data = @empire.describe 'salesforce', 'table1'
      }.to raise_error(Empire::APIError, "Something is broken")
    end
  end

  describe ".query" do
    it "runs queries" do
      # use a StringIO object to mock an IO, then compare contents to
      # the contents of the file read by the API mock
      response = StringIO.new('', 'r+')
      @empire.query 'SELECT * FROM salesforce_account' do |l|
        response.write l
      end
      response.rewind
      response.read.should eq(File.new('spec/query_response_body.txt').read)
    end
  end

  describe ".materialize_view" do
    it "creates views" do
      @empire.materialize_view 'viewName', 'SELECT QUERY'

      a_request(:put, @empire.base_url + "view/viewName").
        with(:body => '{"query":"SELECT QUERY"}').should have_been_made.once
    end
  end

  describe ".drop_view" do
    it "deletes views" do
      @empire.drop_view 'viewName'

      a_request(:delete, @empire.base_url + "view/viewName").should have_been_made.once
    end
  end
end
