require 'empire'

app_key = ARGV[0] or 'YOUR_APP_KEY'
secrets_path = ARGV[1] or 'empire_service_secrets.yaml'
end_user = 'enduser_handle'

empire = Empire.new(app_key, {
	end_user: end_user,
	secrets_yaml: secrets_path
})

empire.walkthrough
