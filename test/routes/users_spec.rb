require_relative '../spec_helper'

describe 'Users' do

  describe 'Post to /users' do

    it 'should return status 200(OK) if correct params' do
      params = {
          name: 'Harry Potter',
          email: 'imawizard@hogwarts.com',
          postcode: '9314'
      }
      post '/users', params
      expect(last_response).to be_ok
    end

    xit 'should return status 500 if incorrect params' do
      params = {
          fail: 'Incorrect Param'
      }
      post '/users', params
      expect(last_response.status).to eq(500)
    end

    it 'should still return status 200(OK) if no optional param' do
      params = {
          name: 'No postcode',
          email: 'no@postcode.com'
      }
      post '/users', params
      expect(last_response).to be_ok
    end

    it 'should return UUID' do
      params = {
          name: 'Severus Snape',
          email: 'dumbledont@deatheaterz.com'
      }
      post '/users', params
      expect(last_response.body).to match(/[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}/)
    end

    it 'should create user in db' do
      params = {
          name: 'Severus Snape',
          email: 'dumbledont@deatheaterz.com'
      }
      post '/users', params
      u = User.first
      expect(u.name).to eq(params[:name])
      expect(u.email).to eq(params[:email])
    end

  end

  describe 'Post to /users/confirm' do

    it 'post /users/confirm should return success code' do
      post '/users/confirm'
      check_last_response_is_ok
    end

  end

end
