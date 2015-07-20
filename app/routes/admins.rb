require_relative 'routing_locations'
require 'json'

get RoutingLocations::ADMIN  + '/?' do
  return status 401 unless warden.authenticated?
  
  @recipients = JSON.parse(Recipient.all.to_json)

  erb :admin
end