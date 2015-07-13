require_relative 'routing_locations'
require_relative '../helpers/param_validation_helper'

get RoutingLocations::REPORTS + '/?' do
  return status 500 unless validate_get_params?(params)

  return Report.find_by(uuid: params[:uuid]).to_json unless params[:uuid].nil?

  return Report.all.to_json
end


post RoutingLocations::REPORTS do
  return status 500 unless validate_post_params?(params)
  status 200
end


def validate_get_params?(params)
  permitted = %w(uuid)
  required = %w()
  params_permitted?(params, permitted) && params_required?(params, required)
end

def validate_post_params?(params)
  permitted = %w(uuid lat long category description)
  required = %w(uuid lat long category)
  params_permitted?(params, permitted) && params_required?(params, required)
end

