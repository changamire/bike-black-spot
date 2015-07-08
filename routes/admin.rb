require_relative 'routing_locations'

get RoutingLocations::ADMIN  + '/?' do
  warden.authenticate!
  erb :admin
end

get RoutingLocations::LOGOUT  + '/?' do
  warden.logout if warden.authenticated?
  redirect RoutingLocations::ROOT
end

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