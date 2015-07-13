require_relative 'routing_locations'
require_relative '../helpers/param_validation_helper'

get RoutingLocations::REPORTS + '/?' do
  permitted = %w(uuid)
  required = %w()
  return status 500 unless validate_params?(params,permitted,required)

  return Report.find_by(uuid: params[:uuid]).to_json unless params[:uuid].nil?

  return Report.all.to_json
end


post RoutingLocations::REPORTS do
  permitted = %w(uuid lat long category description)
  required = %w(uuid lat long category)
  return status 500 unless validate_params?(params,permitted,required)

  user = User.find_by(uuid: params[:uuid])
  category = Category.find_by(uuid: params[:category])
  unless user.nil? or category.nil?
    Report.create(user: user, category: category, lat: params[:lat], long: params[:long],
                  description: params[:description])
  end
end

