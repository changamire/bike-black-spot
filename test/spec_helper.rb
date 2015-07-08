# require 'rubygems's
# require 'bundler'
# Bundler.setup(:default, :test)
require 'sinatra'
require 'rspec'
require 'json'
require 'rack/test'

include Rack::Test::Methods

def app
  Sinatra::Application
end
	
# set test environment
Sinatra::Base.set :environment, :test
Sinatra::Base.set :run, false
Sinatra::Base.set :raise_errors, true
Sinatra::Base.set :logging, false # ?? not using this logging?

require File.join(File.dirname(__FILE__), '../app')

# establish in-memory database for testing
# DataMapper.setup(:default, "sqlite3::memory:")
# Mongoid.load!("")
RSpec.configure do |config|

  # reset database before each example is run
  # config.before(:each) { DataMapper.auto_migrate! }
end

def check_last_response_is_ok
  expect(last_response).to be_ok
end
