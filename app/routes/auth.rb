require_relative '../models/admin'

get '/login/?' do
  redirect '/admin' if warden.authenticated?
  erb :login
end

post '/login' do

  permitted = %w(username password)
  required = %w(username password)

  return status 400 unless validate_params?(params, permitted, required)

  warden.authenticate!

  redirect '/admin'
end

get '/logout/?' do
  warden.logout if warden.authenticated?
  redirect '/'
end
