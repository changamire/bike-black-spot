require './app'

Mongoid.load!(File.join(File.dirname(__FILE__), 'config', 'mongoid.yml'))
enable :sessions
set :logging, Logger.new($stdout)
run BikeSpot
