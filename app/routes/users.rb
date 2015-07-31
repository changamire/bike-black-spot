require_relative '../helpers/param_validation_helper'

post '/users/?' do
  ENV['server'] = request.env['SERVER_NAME']
  permitted = %w(name email postcode)
  required = %w(name email)
  return status 400 unless validate_params?(params, permitted, required)

  user = User.create(params)
  return status 400 unless user.valid?

  response['Location'] = "#{request.url}?uuid=#{user.uuid}"
  return user.uuid.to_json
end

get '/users/?' do
  permitted = %w(uuid)
  required = %w(uuid)
  return status 400 unless validate_params?(params, permitted, required)
  user = User.find_by(uuid: params[:uuid])
  return status 400 if user.nil?
  return [confirmed: user.confirmed].to_json
end

get '/users/confirm/?', :agent => /iPhone/ do
  params.delete(:agent)
  return status 400 unless confirm_user(params)
  redirect 'bikeblackspot://'
end

get '/users/confirm/?' do
  return status 400 unless confirm_user(params)
  redirect '/?confirm=true'
end

def confirm_user(params)
  permitted = %w(token)
  required = %w(token)
  return false unless validate_params?(params, permitted, required)

  confirmation = Confirmation.find_by(token: params[:token])
  return false if confirmation.nil?

  user = User.find_by(uuid: confirmation.user)
  return false if user.nil?
  user.confirmed = true
  user.save!
  reports = Report.where(user: user)
  reports.each do |report|
    if report.sent_at.nil?
      Mailer.send_reports(report)
    end
  end
  return true
end
