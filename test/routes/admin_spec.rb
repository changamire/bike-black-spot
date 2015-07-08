require 'rack/test'
require_relative '../spec_helper'

ENV['RACK_ENV'] = 'test'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe 'Admin routes' do

  it 'get /admin should have status 302 when unauthorised' do
    get '/admin'
    check_response_is_redirected
  end

  it 'get /admin should redirect to login when unauthorised' do
    get '/admin'
    expect(last_response.location).to include('/login')
  end

  it 'get /admin should not redirect when authorised' do
    login_as :Admin
    get '/admin'
    expect(last_response.status).to_not be(302)
    check_last_response_is_ok
  end
end

describe 'Admin/login routes' do
  xit 'post /login with invalid credentials should not redirect' do
    post '/login', params={username:'admin',password:'password'}
    expect(last_response.status).to_not be(302)
  end

  xit 'post /login with valid credentials should redirect to /admin' do

  end
end

describe '/logout routes' do
  it 'get /logout should redirect' do
    get '/logout'

    expect(last_response.status).to be(302)
  end

  it 'get /logout should logout of warden' do
    login_as :Admin
    get '/logout'
    get '/admin'
    expect(last_response.location).to include('/login')
  end
end


