require_relative '../helpers/param_validation_helper'

post '/users' do

  if validate_params?(params)
    u = User.create(params)
    return u.uuid.to_json if u.valid?
  end
  status 500
  'Invalid Parameters'
end

post '/users/confirm/?' do
  'user confirm page'
end

def validate_params?(params)
  permitted = %w(name email postcode)
  required = %w(name email)
  params_permitted?(params, permitted) && params_required?(params, required)
end
