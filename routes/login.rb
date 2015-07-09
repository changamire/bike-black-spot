require_relative 'routing_locations'
require_relative '../models/admin'

get RoutingLocations::LOGIN  + '/?' do
  redirect RoutingLocations::ADMIN if warden.authenticated?
  erb :login
end

post RoutingLocations::LOGIN do
  # Admin.create(username:'admin',password:'password!')

  warden.authenticate!
  redirect RoutingLocations::ADMIN
end

get RoutingLocations::LOGOUT  + '/?' do
  warden.logout if warden.authenticated?
  redirect RoutingLocations::ROOT
end

