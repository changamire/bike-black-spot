require './app'

use Rack::Session::Cookie, :secret => 'replace this with some secret key'

Sinatra::Application.run!
