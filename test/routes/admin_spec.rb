ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'sinatra'
require 'rack/test'
require_relative '../../routes/admin'

describe 'admin' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'get recipient should return success code' do
    get '/recipient'
    check_last_response_is_ok
  end
  it 'patch recipient should return success code' do
    patch '/recipient'
    check_last_response_is_ok
  end
  it 'post recipient should return success code' do
    post '/recipient'
    check_last_response_is_ok
  end
end

def check_last_response_is_ok
  expect(last_response).to be_ok
end
