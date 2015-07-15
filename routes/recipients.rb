require_relative 'routing_locations'
require_relative '../helpers/param_validation_helper'


get RoutingLocations::RECIPIENTS + '/?' do
  return 401 unless warden.authenticated?
  permitted = %w(uuid)
  required = %w()

  return status 400 unless validate_params?(params, permitted, required)

  return Recipient.all.to_json if params[:uuid].nil?

  recipient = Recipient.find_by(uuid: params[:uuid])
  # status 400 if recipient.nil?
  return recipient.to_json

end

post RoutingLocations::RECIPIENTS + '/?' do
  return 401 unless warden.authenticated?

  permitted = %w(name email state)
  required = %w(name email state)

  return status 400 unless validate_params?(params, permitted, required)

  Recipient.create(params)
  status 201
end

delete '/recipients' do
  return 401 unless warden.authenticated?

  permitted = %w(uuid)
  required = %w(uuid)

  return status 400 unless validate_params?(params, permitted, required)

  recipient = Recipient.find_by(uuid: params[:uuid])
  return status 400 if recipient.nil?

  recipient.delete
  status 204
end