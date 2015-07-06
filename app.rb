require 'sinatra'
require 'mongoid'
require 'json'
require_relative 'app/user.rb'
require_relative 'app/map.rb'
require_relative 'app/root.rb'
require_relative 'app/report.rb'
require_relative 'helpers/api_logger.rb'
require_relative 'routes/init'

class BikeSpot < Sinatra::Base
  Mongoid.load!(File.join(File.dirname(__FILE__), 'config', 'mongoid.yml'))
  enable :sessions
  set :logging, Logger.new($stdout)
end
