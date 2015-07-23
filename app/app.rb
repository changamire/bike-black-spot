require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'rack/throttle'
require 'rack/ssl'

require_relative '../config/config.rb'
require_relative 'models/init'
require_relative 'routes/init'
require_relative 'helpers/init'

set :logging, true

class BikeSpot < Sinatra::Application
  register Sinatra::ActiveRecordExtension
  register Sinatra::Flash

  set :root, File.dirname(__FILE__)

end
