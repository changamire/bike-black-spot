def warden
  env['warden']
end

class BikeSpotWarden  < Sinatra::Base
  Warden::Strategies.add(:password) do
    def valid?
      params['username'] || params['password']
    end

    def authenticate!
      # Add username stuff
      begin
        # Expand
        admin = Admin.first!

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
  post RoutingLocations::UNAUTHENTICATED do
    redirect RoutingLocations::LOGIN
  end

  get RoutingLocations::UNAUTHENTICATED do
    redirect RoutingLocations::LOGIN
  end
end

use Rack::Session::Cookie, :secret => 'Michael is a god'
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
