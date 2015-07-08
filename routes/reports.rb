require_relative 'routing_locations'

get RoutingLocations::REPORTS + '/?' do
	env['warden'].authenticate!
  status 200
  # @Report.all.to_json
end

get RoutingLocations::REPORTS + '/:uuid' do
	r = Report.find(params[:uuid])
	r.to_json
end

post RoutingLocations::REPORTS do
	# r = Response.new(user: params[:uuid], location: params[:location],
	# 										notes: params[:notes], image: param[:image])
	r.create
	status 201
	# r.to_json
end
