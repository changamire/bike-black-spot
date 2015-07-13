require_relative 'routing_locations'
require_relative '../helpers/param_validation_helper'

get RoutingLocations::REPORTS + '/?' do
  return status 500 unless validate_get_params?(params)

  return Report.find_by(uuid: params[:uuid]).to_json unless params[:uuid].nil?

  return Report.all.to_json
end


post RoutingLocations::REPORTS do
  return status 500 unless validate_post_params?(params)

  user = User.find_by(uuid: params[:uuid])
  category = Category.find_by(uuid: params[:category])
  unless user.nil? or category.nil?
    Report.create(user: user, category: category, lat: params[:lat], long: params[:long],
                  description: params[:description])
  end
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

