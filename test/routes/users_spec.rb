ENV['RACK_ENV'] = 'test'

require 'rack/test'
require_relative '../spec_helper'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe 'Users' do
  it 'get /user/confirm should return success code' do
    post '/user/confirm'
    check_last_response_is_ok
  end
end
