require File.expand_path("../app/app.rb", __FILE__)
require File.expand_path("../config/config.rb", __FILE__)

require 'rack/throttle'
require 'rack/ssl'

#\-p 4567
run Sinatra::Application
