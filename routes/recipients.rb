require_relative 'routing_locations'

get RoutingLocations::RECIPIENTS + '/?' do
  return status 500 unless validate_get_params?(params)
  return Recipient.find_by(uuid: params[:uuid]).to_json unless params[:uuid].nil?
  Recipient.all.to_json
end


def validate_get_params?(params)
  permitted = %w(uuid)
  required = %w()
  params_permitted?(params, permitted) && params_required?(params, required)
end