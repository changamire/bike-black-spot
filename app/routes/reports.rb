require_relative 'routing_locations'
require_relative '../helpers/param_validation_helper'

get RoutingLocations::REPORTS + '/?' do
  permitted = %w(uuid)
  required = %w()
  return status 400 unless validate_params?(params, permitted, required)

  return Report.json(warden.authenticated?) if params[:uuid].nil?

  report = Report.find_by(uuid: params[:uuid])
  # status 400 if report.nil?
  return report.to_json
end


post RoutingLocations::REPORTS do
  permitted = %w(uuid lat long category description)
  required = %w(uuid lat long category)
  return status 400 unless validate_params?(params, permitted, required)

  user = User.find_by(uuid: params[:uuid])
  category = Category.find_by(uuid: params[:category])
  return status 400 if user.nil? or category.nil?

  location = Location.create(lat: params[:lat], long: params[:long])
  Report.create(user: user, category: category, location: location.uuid,
                description: params[:description])
  return status 201
end

