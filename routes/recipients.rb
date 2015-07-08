get '/recipients' do
  "gets a recipient"
 	# name (string)
	# email (string)
	# location (id? ref to db mapping to GeoJSON)
	# category (string)
	# Response: 200
	# 500 errors
	# 403 - unauth
end

get '/recipients/export' do
	#requires auth
	"dumps everything"
end
