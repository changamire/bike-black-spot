get '/admin' do
  env['warden'].authenticate!

  erb :admin
  # redirect '/categories'
end
get '/admin/login/?' do
  erb :login
end

post '/admin/login/?' do
  env['warden'].authenticate!

  flash[:success] = env['warden'].message

  if session[:return_to].nil?
    redirect '/'
  else
    redirect '/admin'
    # redirect session[:return_to]
  end
end


get '/logout/?' do
  'hi log'
end