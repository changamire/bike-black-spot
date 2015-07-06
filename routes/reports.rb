get '/reports' do
	status 200
  # @Report.all.to_json
end

post '/reports' do
	# r = Response.create(user: params[:uuid], location: params[:location],
	# 										notes: params[:notes], image: param[:image])
	status 201
	# r.to_json
end
