require 'sinatra'
require 'json'
require 'sinatra/activerecord'
require 'warden'
require 'bcrypt'
require 'rack/throttle'

require_relative 'models/init'
require_relative 'helpers/api_logger.rb'
require_relative 'routes/init'
require_relative 'environments'
require_relative 'models/admin'
require_relative 'helpers/bike_spot_warden'

use Rack::Throttle::Minute, :max => 1000 if ENV['RACK_ENV'] == 'production'

class BikeSpot < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  enable :sessions

end