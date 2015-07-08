def warden
  env['warden']
end

class BikeSpotWarden  < Sinatra::Base
  Warden::Manager.serialize_into_session do |user|
    user.object_id
  end

  Warden::Manager.serialize_from_session do |object_id|
    Admin.get(object_id)
  end

  Warden::Strategies.add(:password) do
    def valid?
      params['username'] || params['password']
    end

    def authenticate!
      # Add username stuff
      admin = Admin.first(username: params['user']['username'])

      if admin.nil?
        fail!('The username you entered does not exist.')
      elsif admin.authenticate(params['user']['password'])
        success!(admin)
      else
        fail!('Could not log in')
      end
    end
  end

  #Routing -- DO NOT MOVE --
  get RoutingLocations::UNAUTHENTICATED do
    redirect RoutingLocations::LOGIN
  end
end

use Warden::Manager do |manager|
  manager.default_strategies :password
  manager.failure_app = BikeSpotWarden.new
end
