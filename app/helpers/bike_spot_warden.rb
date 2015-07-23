require 'warden'

def warden
  env['warden']
end

LOCAL_KEY = 'BfgDs55HmHgHsECGG2Wxb28tqD7sB4a24xPDqth42XSu6x4UVtU6HNR3pjf2mPW477QuxzqQw33xgQyNrBAgn37bS8cMnDqd4kXX'

class BikeSpotWarden < Sinatra::Base
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
          raise 'Authentication failed'
        end
      rescue Exception => e
        fail!(e)
      end
    end
  end

  #Routing -- DO NOT MOVE --
  post '/unauthenticated' do
    status 401
    redirect '/login' if env['warden.options'][:attempted_path] == '/admin' or
        env['warden.options'][:attempted_path] == '/login'
  end

  get '/unauthenticated' do
    redirect '/login' if env['warden.options'][:attempted_path] == '/admin'
    status 401
  end

  delete '/unauthenticated' do
    status 401
  end
end

use Rack::Session::Cookie, :secret => ENV['WARDEN_KEY'] || LOCAL_KEY,
                           :expire_after => 3600
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
