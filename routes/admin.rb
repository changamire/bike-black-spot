get '/admin/?' do
  env['warden'].authenticate!
  erb :admin
end

get '/logout/?' do
  env['warden'].logout if env['warden'].authenticated?
  redirect '/'
end

get '/login/?' do
  redirect '/admin' if env['warden'].authenticated?

  erb :login
end

post '/login/?' do
  env['warden'].authenticate!

  flash[:success] = env['warden'].message

  if session[:return_to].nil?
    redirect '/'
  else
    redirect '/admin'
    # redirect session[:return_to]
  end
end