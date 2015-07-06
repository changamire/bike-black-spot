get '/recipient' do
  "gets a recipient"
 	# name (string)
	# email (string)
	# location (id? ref to db mapping to GeoJSON)
	# category (string)
	# Response: 200
	# 500 errors
	# 403 - unauth
end

get '/recipient/export' do
	#requires auth
	"dumps everything"
end
