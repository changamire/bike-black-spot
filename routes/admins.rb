require_relative 'routing_locations'

get RoutingLocations::ADMIN  + '/?' do
  warden.authenticate!
  erb :admin
end