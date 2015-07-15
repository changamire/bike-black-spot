require 'rack/test'
require_relative '../spec_helper'
require_relative '../../routes/routing_locations'

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
      expect(last_response.location).to eql(LOCAL + RoutingLocations::LOGIN)
    end

    it 'should not redirect when authorised' do
      login_as :Admin
      get RoutingLocations::ADMIN
      expect(last_response.redirect?).to be(false)
      check_last_response_is_ok
    end
  end
end


