require_relative 'routing_locations'

get RoutingLocations::ROOT  + '/?' do
  erb :index
end