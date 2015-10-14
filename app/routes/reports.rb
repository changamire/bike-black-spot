require_relative '../helpers/param_validation_helper'

get '/reports/?' do
  permitted = %w(uuid)
  required = %w()
  return status 400 unless validate_params?(params, permitted, required)

  return Report.json(warden.authenticated?) if params[:uuid].nil?

  report = Report.find_by(uuid: params[:uuid])
  # status 400 if report.nil?
  return report.to_json
end

get '/reports/confirmed/?' do
  permitted = %w()
  required = %w()
  return status 400 unless validate_params?(params, permitted, required)

  return Report.json(warden.authenticated?, confirmed: true)
end


post '/reports/?' do
  permitted = %w(uuid lat long category description image)
  required = %w(uuid lat long category)
  return status 400 unless validate_params?(params, permitted, required)

  user = User.find_by(uuid: params[:uuid])
  category = Category.find_by(uuid: params[:category])
  return status 400 if user.nil? or category.nil?

  location = Location.create(lat: params[:lat], long: params[:long])
  return status 400 unless location.valid?
  
  report = Report.create(user: user, category: category, location: location,
               description: params[:description], image: params[:image])

  return status 400 unless report.valid?

  Mailer.send_reports(report) if user.confirmed?

  response['Location'] = "#{request.url}?uuid=#{report.uuid}"
  return status 201
end
