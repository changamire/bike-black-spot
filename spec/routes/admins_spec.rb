describe 'Admin' do
  describe 'get /admin'  do
    it 'should redirect to login when unauthorised' do
      get '/admin'
      expect(last_response.redirect?).to be(true)
      expect(last_response.status).to be(302)
      expect(last_response.location).to eql(LOCAL + '/login')
    end

    it 'should not redirect when authorised' do
      login_as :Admin
      get '/admin'
      expect(last_response.redirect?).to be(false)
      expect(last_response.status).to be(200)
    end
  end
end
