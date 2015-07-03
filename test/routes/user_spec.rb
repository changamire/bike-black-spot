ENV['RACK_ENV'] = 'test'

require 'rack/test'
require_relative '../../routes/user'
require_relative '../spec_helper'

describe 'user' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'root "/" should return success code' do


    get '/'
    check_last_response_is_ok
  end

  it '/user/confirm should return success code' do
    get '/user/confirm'
    check_last_response_is_ok
  end

  it '/reports should return success code' do
    get '/reports'
    check_last_response_is_ok
  end

  it '/reports/:report_id should return success code' do
    get '/reports?report_id=1'
    check_last_response_is_ok
  end

  it '/reports/:report_id:full_report should return success code' do
    get '/reports', params={report_id:1, full_report:true}
    check_last_response_is_ok
  end

  it '/categories should return success code' do
    get '/categories'
    check_last_response_is_ok
  end
end

def check_last_response_is_ok
  expect(last_response).to be_ok
end
