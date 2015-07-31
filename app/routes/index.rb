get '/?' do
  erb :index, :locals => {:confirm => params[:confirm]}
end
