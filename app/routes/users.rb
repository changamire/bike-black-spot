require_relative '../helpers/param_validation_helper'

post '/users/?' do
  ENV['server'] = request.env['SERVER_NAME']
  permitted = %w(name email postcode)
  required = %w(name email)
  return status 400 unless validate_params?(params, permitted, required)

  user = User.create(params)
  return status 400 unless user.valid?

  return user.uuid.to_json
end

get '/users/confirm/?' do
  permitted = %w(token)
  required = %w(token)
  return status 400 unless validate_params?(params, permitted, required)

  confirmation = Confirmation.find_by(token: params[:token])
  return status 400 if confirmation.nil?

  user = User.find_by(uuid: confirmation.user)
  return status 400 if user.nil?

  user.confirmed = true
  user.save!

  reports = Report.where(user: user)
  reports.each do |report|
    Mailer.send_report(report)
  end

  redirect '/'
end
