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

    it 'should return status 500 if incorrect params' do
      params = {
          fail: 'Incorrect Param'
      }
      post '/users', params
      expect(last_response.status).to eq(400)
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

    it 'should create a confirmation token' do
      params = {
          name: 'Severus Snape',
          email: 'dumbledont@deatheaterz.com'
      }
      post '/users', params
      u = User.first
      c = Confirmation.first
      expect(c.user).to eq(u.uuid)
    end

  end

  describe 'Get to /users/confirm' do

    it 'should return status code 302 on valid params' do
      user = User.create(name: 'Test', email: 'test@test.com')
      confirmation = Confirmation.create(user: user.uuid)
      get "/users/confirm?token=#{confirmation.token}"
      expect(last_response.status).to eq(302)
    end

    it 'should return status code 500 on invalid params' do
      get '/users/confirm?fail=fial&token=validtoken'
      expect(last_response.status).to eq(400)
    end

    it 'should return status code 500 on no params' do
      get '/users/confirm?'
      expect(last_response.status).to eq(400)
    end

    it 'should confirm user if valid token' do
      user = User.create(name: 'Test', email: 'test@test.com')
      c = Confirmation.create(user: user.uuid)
      token = c.token
      get "/users/confirm?token=#{token}"
      puts last_response.body
      expect(User.find_by(uuid: user.uuid).confirmed).to eq(true)
    end
  end
end

