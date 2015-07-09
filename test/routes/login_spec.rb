require 'rack/test'
require_relative '../spec_helper'
require_relative '../../routes/routing_locations'
require_relative '../../models/admin'

describe 'Login' do
  it 'post ' + RoutingLocations::LOGIN + ' with invalid credentials should not redirect' do
    post RoutingLocations::LOGIN, params={username:'invalid_name',password:'invalid_pw'}

    expect(last_response.location).to eql(LOCAL + RoutingLocations::LOGIN )
  end

  it 'post /login with valid credentials should redirect to /admin' do
    test_admin = Admin.create(username:'userCat',password:'userPass')

    post RoutingLocations::LOGIN, params={username:'userCat',password:'userPass'}

    expect(last_response.redirect?).to be(true)
    expect(last_response.location).to eql(LOCAL + RoutingLocations::ADMIN )

    test_admin.delete
  end
end

describe 'Logout' do
  it 'get '+RoutingLocations::LOGOUT+' should redirect' do
    get RoutingLocations::LOGOUT

    expect(last_response.redirect?).to be(true)
    expect(last_response.location).to eql(LOCAL + RoutingLocations::ROOT)
  end

  it 'get ' + RoutingLocations::LOGOUT + ' should logout of warden (hitting protected page requires login)' do
    login_as :Admin
    get RoutingLocations::LOGOUT
    get RoutingLocations::ADMIN
    expect(last_response.location).to eql(LOCAL + RoutingLocations::LOGIN )
  end
end