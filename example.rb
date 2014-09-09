require 'empire'

app_key = ARGV[0] or 'YOUR_APP_KEY'
secrets_path = ARGV[1] or 'empire_service_secrets.yaml'
enduser = 'enduser_handle'

empire = Empire.new(app_key, {
	enduser: enduser,
	secrets_yaml: secrets_path
})

empire.walkthrough
