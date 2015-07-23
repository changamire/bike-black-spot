require 'sinatra'
require 'rspec'
require 'json'
require 'rack/test'
require 'geokit'
require 'database_cleaner'

include Rack::Test::Methods
require File.join(File.dirname(__FILE__), '../app/app')

def app
  Sinatra::Application
end

# set test environment
Sinatra::Base.set :environment => :development
Sinatra::Base.set :run, false
Sinatra::Base.set :raise_errors, true
Sinatra::Base.set :logging, false
Sinatra::Base.set :views, File.join(File.dirname(__FILE__),'../app/views/')

LOCAL = 'http://example.org'

RSpec.configure do |config|

  config.include Warden::Test::Helpers
  DatabaseCleaner.clean_with(:truncation)

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |test|
    DatabaseCleaner.cleaning do
      test.run
    end
  end

  config.after do
    Warden.test_reset!
  end
end

def check_last_response_is_ok
  expect(last_response).to be_ok
end
