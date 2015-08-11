describe 'Login' do
  it 'post ' + '/login' + ' with invalid credentials should return status 400' do
    post '/login', params={username: 'invalid_name', password: 'invalid_pw'}
    expect(last_response.status).to be(302)
  end

  it 'post /login with valid credentials should redirect to /admin' do
    test_admin = Admin.create(username: 'userCat', password: 'userPass')

    post '/login', params={username: 'userCat', password: 'userPass'}

    test_admin.delete
    expect(last_response.redirect?).to be(true)
    expect(last_response.location).to eql(LOCAL + '/admin')
  end
  it 'post /login with invalid params should return status 400' do
    test_admin = Admin.create(username: 'userCat', password: 'userPass')

    post '/login', params={testingInvalidParam: 'userCat', password: 'userPass'}
    test_admin.delete
    expect(last_response.status).to be(400)

  end
end

describe 'Logout' do
  describe 'get /logout' do
    it 'should redirect' do
      get '/logout'

      expect(last_response.status).to be(302)
      expect(last_response.location).to eql(LOCAL + '/')
    end

    it 'should logout of warden (hitting protected page requires login)' do
      login_as :Admin
      get '/logout'
      expect(last_response.status).to be(302)

      get '/logout'
      expect(last_response.status).to be(302)
      expect(last_response.location).to eql(LOCAL + '/')
    end
  end
end
