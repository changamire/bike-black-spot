require_relative 'routing_locations'
require_relative '../helpers/param_validation_helper'
require_relative '../models/user'
require 'csv'

get RoutingLocations::EXPORTS do
  permitted = %w(users)
  required = %w()

  return status 400 unless validate_params?(params, permitted, required)

  unless (params.has_key?(:users))
    redirect RoutingLocations::LOGIN unless warden.authenticated?
    User.export
  end
end