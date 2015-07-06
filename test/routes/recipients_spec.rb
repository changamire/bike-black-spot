ENV['RACK_ENV'] = 'test'

require 'rack/test'
require_relative '../spec_helper'

describe 'Recipient' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'get recipient should return success code' do
    get '/recipient'
    check_last_response_is_ok
  end
end
