require_relative 'routing_locations'

get RoutingLocations::ADMIN  + '/?' do
  return status 401 unless warden.authenticated?
  erb :admin
end