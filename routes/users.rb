require_relative '../helpers/param_validation_helper'

post '/users' do
  if validate_params?(params)
    u = User.create(params)
    return u.uuid.to_json
  end
  status 500
end

post '/users/confirm' do
  'user confirm page'
end


def validate_params?(params)
  permitted = ['name', 'email', 'postcode']
  required = ['name', 'email']
  params_permitted?(params, permitted) && params_required?(params, required)
end
