require 'rack/test'
require_relative '../spec_helper'
require_relative '../../routes/routing_locations'

ENV['RACK_ENV'] = 'test'
include Rack::Test::Methods

def app
  Sinatra::Application
end

describe 'Admin routes' do
  it 'get ' + RoutingLocations::ADMIN + ' should have status 302 when unauthorised' do
    get RoutingLocations::ADMIN
    check_response_is_redirected
  end

  it 'get ' + RoutingLocations::ADMIN + ' should redirect to login when unauthorised' do
    get RoutingLocations::ADMIN
    expect(last_response.location).to include(RoutingLocations::LOGIN)
  end

  it 'get ' + RoutingLocations::ADMIN + ' should not redirect when authorised' do
    login_as :Admin
    get RoutingLocations::ADMIN
    expect(last_response.status).to_not be(302)
    check_last_response_is_ok
  end
end

describe RoutingLocations::LOGIN+' routes' do
  xit 'post ' + RoutingLocations::LOGIN + ' with invalid credentials should not redirect' do
    post RoutingLocations::LOGIN, params={username:'admin',password:'password'}
    expect(last_response.status).to_not be(302)
  end

  xit 'post /login with valid credentials should redirect to /admin' do

  end
end

describe RoutingLocations::LOGOUT + ' routes' do
  it 'get '+RoutingLocations::LOGOUT+' should redirect' do
    get RoutingLocations::LOGOUT

    expect(last_response.status).to be(302)
  end

  it 'get ' + RoutingLocations::LOGOUT + ' should logout of warden' do
    login_as :Admin
    get RoutingLocations::LOGOUT
    get RoutingLocations::ADMIN
    expect(last_response.location).to include(RoutingLocations::LOGIN)
  end
end


