require_relative 'routing_locations'

get RoutingLocations::LOGIN  + '/?' do
  redirect RoutingLocations::ADMIN if warden.authenticated?
  erb :login
end

post RoutingLocations::LOGIN do
  warden.authenticate!

  flash[:success] = warden.message

  if session[:return_to].nil?
    redirect RoutingLocations::ROOT
  else
    redirect RoutingLocations::ADMIN
  end
end

get RoutingLocations::LOGOUT  + '/?' do
  warden.logout if warden.authenticated?
  redirect RoutingLocations::ROOT
end

