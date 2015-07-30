require_relative '../helpers/param_validation_helper'
require_relative '../models/user'
require 'csv'
require 'zip'

get '/exports/?' do

  permitted = %w(users reports)
  required = %w()

  return status 400 unless validate_params?(params, permitted, required)
  return status 401 unless warden.authenticated?

  content_type 'application/csv'
  if params[:users]
    attachment 'users-encrypted.zip'
    return Zip::OutputStream.write_buffer(::StringIO.new(''), Zip::TraditionalEncrypter.new(ENV['USER_ENCRYPTION_PASSWORD'])) do |out|
      out.put_next_entry('users.csv')
      out.write User.export
    end.string
    return
  else
    if params[:reports]
      attachment 'reports.csv'
      reports = Report.export
      return reports
    end
  end
end