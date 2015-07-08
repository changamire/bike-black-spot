get '/reports/?' do
	env['warden'].authenticate!
  status 200
  # @Report.all.to_json
end

get '/reports/:uuid' do
	r = Report.find(params[:uuid])
	r.to_json
end

post '/reports/?' do
	# r = Response.new(user: params[:uuid], location: params[:location],
	# 										notes: params[:notes], image: param[:image])
	r.create
	status 201
	# r.to_json
end
