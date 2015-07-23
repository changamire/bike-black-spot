require_relative '../helpers/param_validation_helper'
require_relative '../models/user'
require 'csv'

get '/exports/?' do

  permitted = %w(users)
  required = %w()

  return status 400 unless validate_params?(params, permitted, required)
  return status 401 unless warden.authenticated?

  content_type 'application/csv'
  attachment   'reports.csv'
  User.export if params[:users]
end
