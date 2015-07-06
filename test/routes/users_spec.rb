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

  describe 'post to users' do
    # it 'should have have params'
    # it 'should handle optional params'
    # it 'should return 200 (OK)'
    # it 'should return 500 on errors'
    # it 'should return UUID'
    # it 'should send email'
    # it 'should create user in db'
  end
