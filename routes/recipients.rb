require_relative 'routing_locations'
require_relative '../helpers/param_validation_helper'


get RoutingLocations::RECIPIENTS + '/?' do
  permitted = %w(uuid)
  required = %w()

  return status 500 unless validate_params?(params, permitted, required)

  return Recipient.find_by(uuid: params[:uuid]).to_json unless params[:uuid].nil?

  Recipient.all.to_json
end

post RoutingLocations::RECIPIENTS + '/?' do
  redirect RoutingLocations::LOGIN unless warden.authenticated?

  permitted = %w(name email state)
  required = %w(name email state)

  return status 500 unless validate_params?(params, permitted, required)


  Recipient.create(params)
  status 201
end



delete '/recipients' do
  redirect RoutingLocations::LOGIN unless warden.authenticated?

  permitted = %w(uuid)
  required = %w()

  return status 500 unless validate_params?(params, permitted, required)

  recipient = Recipient.find_by(uuid: params[:uuid])
  recipient.delete
end