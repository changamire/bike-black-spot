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
      user = User.first
      expect(user.name).to eq(params[:name])
      expect(user.email).to eq(params[:email])
    end

    it 'should create a confirmation token' do
      params = {
          name: 'Severus Snape',
          email: 'dumbledont@deatheaterz.com'
      }
      post '/users', params
      user = User.first
      confirmation = Confirmation.first
      expect(confirmation.user).to eq(user.uuid)
    end

  end

  describe 'Get to /users/confirm' do

    it 'should return status code 302 on valid params' do
      user = User.create(name: 'Test', email: 'test@test.com')
      confirmation = Confirmation.create(user: user.uuid)
      get "/users/confirm?token=#{confirmation.token}"
      expect(last_response.status).to eq(302)
    end

    it 'should return status code 400 on invalid params' do
      get '/users/confirm?fail=fial&token=validtoken'
      expect(last_response.status).to eq(400)
    end

    it 'should return status code 400 on no params' do
      get '/users/confirm?'
      expect(last_response.status).to eq(400)
    end

    it 'should return status code 400 on empty token' do
      get '/users/confirm?token='
      expect(last_response.status).to eq(400)
    end

    it 'should confirm user if valid token' do
      user = User.create(name: 'Test', email: 'test@test.com')
      token = Confirmation.find_by(user: user.uuid).token
      get "/users/confirm?token=#{token}"
      expect(User.find_by(uuid: user.uuid).confirmed).to be_truthy
    end

    it 'should return status 400 if user does not exist anymore' do
      user = User.create(name: 'Test', email: 'test@test.com')
      token = Confirmation.find_by(user: user.uuid).token
      user.delete
      get "/users/confirm?token=#{token}"
      expect(last_response.status).to eq(400)
    end

    it 'should send unsent reports associated with user' do
      Recipient.create(name: 'Rec Pient', email: 'VICrecipient@gmail.com', state: 'VIC')
      location = Location.create(lat: '-37.816684', long: '144.963962')
      user = User.create(name: 'Tom', email: 't@l.com')
      token = Confirmation.find_by(user: user.uuid).token
      category = Category.create(name: 'category1', description: 'valid description')

      Report.create(user: user, category: category, location: location, description: 'This is a description1')
      Report.create(user: user, category: category, location: location, description: 'This is a description2')
      Report.create(user: user, category: category, location: location, description: 'This is a description3')

      Mail::TestMailer.deliveries.clear

      get "/users/confirm?token=#{token}"
      expect(Mail::TestMailer.deliveries.length).to eq(6)

    end
  end
end
