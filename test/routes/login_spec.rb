require 'rack/test'
require_relative '../spec_helper'
require_relative '../../routes/routing_locations'

describe 'Login' do
  xit 'post ' + RoutingLocations::LOGIN + ' with invalid credentials should not redirect' do
    post RoutingLocations::LOGIN, params={username:'admin',password:'password'}
    expect(last_response.status).to_not be(302)
  end

  xit 'post /login with valid credentials should redirect to /admin' do

  end
end

describe 'Logout' do
  it 'get '+RoutingLocations::LOGOUT+' should redirect' do
    get RoutingLocations::LOGOUT

    expect(last_response.status).to be(302)
  end

  it 'get ' + RoutingLocations::LOGOUT + ' should logout of warden (hitting protected page requires login)' do
    login_as :Admin
    get RoutingLocations::LOGOUT
    get RoutingLocations::ADMIN
    expect(last_response.location).to include(RoutingLocations::LOGIN)
  end
end