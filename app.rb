require 'sinatra'
require 'json'
require 'sinatra/activerecord'
require 'warden'
require 'bcrypt'

require_relative 'models/init'
require_relative 'helpers/api_logger.rb'
require_relative 'routes/init'
require_relative 'environments'
require_relative 'models/admin'
require_relative 'helpers/bike_spot_warden'

class BikeSpot < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  enable :sessions

end
