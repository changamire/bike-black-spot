require 'sinatra'
require 'mongoid'
require 'json'
require "sinatra/activerecord"
require_relative 'models/init'
require_relative 'helpers/api_logger.rb'
require_relative 'routes/init'

set :database, {adapter: "sqlite3", database: "foo.sqlite3"}
class BikeSpot < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  enable :sessions
  set :logging, Logger.new($stdout)
end
