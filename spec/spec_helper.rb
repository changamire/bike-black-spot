require 'sinatra'
require 'rspec'
require 'rack/test'
require 'database_cleaner'

require File.join(File.dirname(__FILE__), '../app/app')
require File.join(File.dirname(__FILE__), '../config/config')

# set test environment
Sinatra::Base.set :environment => :development
Sinatra::Base.set :views, File.join(File.dirname(__FILE__),'../app/views/')
Sinatra::Base.set :run, false
Sinatra::Base.set :raise_errors, true
Sinatra::Base.set :logging, false
Sinatra::Base.set :views, File.join(File.dirname(__FILE__),'../app/views/')

LOCAL = 'http://example.org'

RSpec.configure do |config|
  include Rack::Test::Methods

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

def app
  Sinatra::Application
end
