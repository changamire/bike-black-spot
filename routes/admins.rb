require_relative 'routing_locations'

get RoutingLocations::ADMIN  + '/?' do
  redirect RoutingLocations::LOGIN unless warden.authenticated?
  erb :admin
end