require_relative '../helpers/param_validation_helper'
require_relative '../models/user'
require 'csv'

get '/exports/?' do

  permitted = %w(users reports)
  required = %w()

  return status 400 unless validate_params?(params, permitted, required)
  return status 401 unless warden.authenticated?

  content_type 'application/csv'
  if params[:users]
    attachment 'users.csv'
    return User.export
  else
    if params[:reports]
      attachment 'reports.csv'
      reports = Report.export
      return reports
    end
  end
end