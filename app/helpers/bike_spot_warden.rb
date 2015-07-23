require 'warden'
require 'sinatra/flash'

def warden
  env['warden']
end

class BikeSpotWarden < Sinatra::Base
  register Sinatra::Flash
  Warden::Strategies.add(:password) do
    def valid?
      params['username'] || params['password']
    end

    def authenticate!
      begin
        admin = Admin.where(username: params['username']).first

        if admin.authenticate(params['password'])
          success!(admin)
        else
          fail! 'Authentication failed'
        end
      rescue Exception => e
        fail!(e)
      end
    end
  end

  #Routing -- DO NOT MOVE --
  post '/unauthenticated' do
    status 401

    redirect '/login' if env['warden.options'][:attempted_path] == '/admin'
    if env['warden.options'][:attempted_path] == '/login'
      flash[:failedLogin] = 'Login failed, please try again.'
      redirect '/login'
    end
  end

  get '/unauthenticated' do
    redirect '/login' if env['warden.options'][:attempted_path] == '/admin'
    status 401
  end

  delete '/unauthenticated' do
    status 401
  end
end

use Warden::Manager do |manager|
  manager.default_strategies :password
  manager.failure_app = BikeSpotWarden.new

  manager.serialize_into_session do |admin|
    admin.object_id
  end

  manager.serialize_from_session do |object_id|
    Admin.object_id
  end
end
