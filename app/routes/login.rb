require_relative 'routing_locations'
require_relative '../models/admin'

get 'login/?' do
  redirect '/admin' if warden.authenticated?
  erb :login
end

post 'login/?' do
  warden.authenticate!
  redirect '/admin'
end

get 'logout/?' do
  warden.logout if warden.authenticated?
  redirect '/'
end

