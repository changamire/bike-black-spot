require_relative '../helpers/param_validation_helper'

post '/users' do
  permitted = %w(name email postcode)
  required = %w(name email)
  if validate_params?(params, permitted, required)
    u = User.create(params)
    return u.uuid.to_json if u.valid?
  end
  status 500
  'Invalid Parameters'
end

get '/users/confirm' do
  permitted = %w(token)
  required = %w(token)
  if validate_params?(params, permitted, required)
    token = params[:token]
    c = Confirmation.find_by(token: token)
    if c.nil?
      return status 500
    else
      u = User.find_by(uuid: c.user)
      u.confirmed = true
      u.save!
      return status 302
    end
  else
    status 500
  end
end