require_relative '../spec_helper'

ENV['RACK_ENV'] = 'test'
include Rack::Test::Methods

def app
  Sinatra::Application
end

describe 'Admin' do
  describe 'get' + RoutingLocations::ADMIN  do
    it 'should redirect to login when unauthorised' do
      get RoutingLocations::ADMIN
      expect(last_response.redirect?).to be(true)
      expect(last_response.status).to be(302)
      expect(last_response.location).to eql(LOCAL + RoutingLocations::LOGIN)
    end

    it 'should not redirect when authorised' do
      login_as :Admin
      get RoutingLocations::ADMIN
      expect(last_response.redirect?).to be(false)
      expect(last_response.status).to be(200)
    end
  end
end


