require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'rack/throttle'
require 'rack/ssl'
require 'geokit'

require_relative 'models/init'
require_relative 'routes/init'
require_relative 'helpers/init'

class BikeSpot < Sinatra::Application
  register Sinatra::ActiveRecordExtension
  register Sinatra::Flash

  set :root, File.dirname(__FILE__)
  set :Logging, true
  set :Sessions, true
end
