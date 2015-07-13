require_relative '../helpers/param_validation_helper'

post '/users' do
  permitted = %w(name email postcode)
  required = %w(name email)
  if validate_params?(params,permitted,required)
    u = User.create(params)
    return u.uuid.to_json if u.valid?
  end
  status 500
  'Invalid Parameters'
end

post '/users/confirm/?' do
  'user confirm page'
end
