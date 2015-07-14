require_relative '../helpers/param_validation_helper'

post '/users' do
  permitted = %w(name email postcode)
  required = %w(name email)
  if validate_params?(params, permitted, required)
    user = User.create(params)
    return user.uuid.to_json if user.valid?
  end
  status 400
  'Invalid Parameters'
end

get '/users/confirm' do
  permitted = %w(token)
  required = %w(token)
  return status 400 unless validate_params?(params, permitted, required)

  confirmation = Confirmation.find_by(token: params[:token])
  return status 400 if confirmation.nil?

  user = User.find_by(uuid: confirmation.user)
  return status 400 if user.nil?

  user.confirmed = true
  user.save!
  return status 302

end