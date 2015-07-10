require_relative 'routing_locations'

get RoutingLocations::RECIPIENTS + '/?' do
  Recipient.all.to_json
end

get RoutingLocations::RECIPIENTS + '/?' do
	#requires auth
  'dumps everything'
end
