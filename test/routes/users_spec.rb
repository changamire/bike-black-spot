ENV['RACK_ENV'] = 'test'

require 'rack/test'
require_relative '../spec_helper'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe 'Users' do

  describe 'Post to /user' do

    it 'should return status 200(OK) if correct params' do
      params = {
          name: 'Harry Potter',
          email: 'imawizard@hogwarts.com',
          postcode: '9314'
      }
      post '/user', params
      expect(last_response).to be_ok
    end

    it 'should return status 500 if incorrect params' do
      params = {
          fail: 'Incorrect Param'
      }
      post '/user', params
      expect(last_response.status).to eq(500)
    end

    it 'should still return status 200(OK) if no optional param' do
      params = {
          name: 'No postcode',
          email: 'no@postcode.com'
      }
      post '/user', params
      expect(last_response).to be_ok
    end

    it 'should return UUID' do
      uuidregex = /[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}/
      params = {
          name: 'Severus Snape',
          email: 'dumbledont@deatheaterz.com'
      }
      post '/user', params
      expect(last_response.body).to match(uuidregex)
    end

    # it 'should send email'
    # it 'should create user in db'
  end

  describe 'Post to /user/confirm' do

    it 'post /user/confirm should return success code' do
      post '/user/confirm'
      check_last_response_is_ok
    end

  end

end