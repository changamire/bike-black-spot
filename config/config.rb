require 'rack/throttle'
require 'rack/ssl'
require 'geokit'


configure :test do
  LOCAL_KEY = 'BfgDs55HmHgHsECGG2Wxb28D7sB4a24xPDqth42XSu6x4UVtU6HNR3pjf2mPW477'
  use Rack::Session::Cookie, :secret => LOCAL_KEY,
                             :expire_after => 3600

  Geokit::Geocoders::secure = false
  Geokit::Geocoders::ssl_verify_mode = OpenSSL::SSL::VERIFY_NONE
end

configure :qa do
  use Rack::SSL
  use Rack::Throttle::Minute, :max => 1000
  use Rack::Session::Cookie, :secret => ENV['WARDEN_KEY'],
                             :expire_after => 3600

  Geokit::Geocoders::secure = false
  Geokit::Geocoders::ssl_verify_mode = OpenSSL::SSL::VERIFY_NONE
end

configure :production do
  use Rack::SSL
  use Rack::Throttle::Minute, :max => 1000
  use Rack::Session::Cookie, :secret => ENV['WARDEN_KEY'],
                             :expire_after => 3600

  Geokit::Geocoders::secure = true
  Geokit::Geocoders::ssl_verify_mode = OpenSSL::SSL::VERIFY_(PEER/NONE)
end
