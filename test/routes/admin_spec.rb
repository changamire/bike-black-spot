ENV['RACK_ENV'] = 'test'

require 'rack/test'
require_relative '../spec_helper'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe 'Admin routes' do

  it 'get /admin should have status 302 when unauthorised' do
    get '/admin'
    check_last_response_is_redirect
  end
  it 'get /admin should redirect to login when unauthorised' do
    get '/admin'
    expect(last_response.location).to include('/admin/login')
  end


  it 'get /admin should not redirect when authorised' do
    login_as :Admin
    get '/admin'
    expect(last_response.status).to_not be(302)
    check_last_response_is_ok
  end


end

describe 'Admin/login routes' do
  xit 'post /admin/login with invalid credentials should not redirect' do
    post '/admin/login', params={username:'admin',password:'password'}
    expect(last_response.status).to_not be(302)
  end
  xit 'post /admin/login with valid credentials should redirect to /admin' do

  end
end


