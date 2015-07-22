require_relative 'routing_locations'
require_relative '../helpers/param_validation_helper'
require_relative '../models/user'
require 'csv'

get RoutingLocations::EXPORTS do

  permitted = %w(users)
  required = %w()

  return status 400 unless validate_params?(params, permitted, required)
  return status 401 unless warden.authenticated?
  results = User.export if (params.has_key?('users'))

  # Set download file type and name
  content_type 'application/csv'
  attachment   'reports.csv'
end