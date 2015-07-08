require_relative 'routing_locations'

get RoutingLocations::RECIPIENTS + '/?' do
  'gets a recipient'
 	# name (string)
	# email (string)
	# location (id? ref to db mapping to GeoJSON)
	# category (string)
	# Response: 200
	# 500 errors
	# 403 - unauth
end

get RoutingLocations::RECIPIENTS + '/?' do
	#requires auth
  'dumps everything'
end
