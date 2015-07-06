require 'sinatra'
require 'mongoid'
require 'json'
require_relative 'models/init'
require_relative 'helpers/api_logger.rb'
require_relative 'routes/init'

class BikeSpot < Sinatra::Base
  Mongoid.load!(File.join(File.dirname(__FILE__), 'config', 'mongoid.yml'))
  enable :sessions
  set :logging, Logger.new($stdout)
end
