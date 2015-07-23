require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'rack/throttle'
require 'rack/ssl'
require 'geokit'

require_relative 'models/init'
require_relative 'routes/init'
require_relative 'helpers/init'

configure :test, :development do
  LOCAL_KEY = 'BfgDs55HmHgHsECGG2Wxb28D7sB4a24xPDqth42XSu6x4UVtU6HNR3pjf2mPW477'
  use Rack::Session::Cookie, :secret => LOCAL_KEY,
                             :expire_after => 3600
end

configure :production do
  use Rack::SSL
  use Rack::Throttle::Minute, :max => 1000
  use Rack::Session::Cookie, :secret => ENV['WARDEN_KEY'],
                             :expire_after => 3600
end

class BikeSpot < Sinatra::Application
  register Sinatra::ActiveRecordExtension
  register Sinatra::Flash

  set :root, File.dirname(__FILE__)

  # Sinatra::Base.set :views, File.join(File.dirname(__FILE__),'/app/views/')

end
