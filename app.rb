require 'sinatra'
require 'mongoid'
require 'json'

require_relative 'routes/init'

class BikeSpot < Sinatra::Base
  # configure do
  #   set :app_file, __FILE__
  # end

  #Load DB Config
  Mongoid.load!('mongoid.yml')
end
