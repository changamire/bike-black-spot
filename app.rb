require 'sinatra'
require 'json'
require 'sinatra/activerecord'
require 'warden'

require_relative 'models/init'
require_relative 'helpers/api_logger.rb'
require_relative 'routes/init'
require_relative 'environments'

class BikeSpot < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  enable :sessions
  set :logging, Logger.new($stdout)


  # -------------
  #     Auth
  # -------------
  Warden::Manager.serialize_into_session do |user|
    user.id
  end

  Warden::Manager.serialize_from_session do |id|
    Admin.get(id)
  end

  get '/unauthenticated/?' do
    'hi un'
  end

  get '/logout/?' do
    'hi log'
  end



  Warden::Strategies.add(:password) do
    def valid?
      params['username'] || params['password']
    end

    def authenticate!
      admin = Admin.authenticate(params['username'], params['password'])
      admin.nil? ?  fail!('Could not log in') : success!(admin)
    end
  end
end

use Warden::Manager do |manager|
  manager.default_strategies :password
  manager.failure_app = BikeSpot
end
