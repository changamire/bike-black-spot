describe 'Exports' do
  describe 'get' do
    describe '/exports?users=true' do

      describe 'when not logged in' do
        describe 'should return status' do
        it '401 given users' do
          get '/exports?users=true'
          expect(last_response.status).to be(401)
        end
        it '400 when given unknown params' do
          get '/exports?hello=true'
          expect(last_response.status).to be(400)
        end
        it '400 when given unknown and correct params' do
          get '/exports?users=wow&notagoodparam'
          expect(last_response.status).to be(400)
        end
          end
      end
      describe 'when logged in' do
        before(:each) do
          login_as :Admin
        end
        it 'should return status 200 when logged in' do
          get '/exports?users=true'
          expect(last_response.status).to be(200)
        end
        xit 'should return categories csv' do
          user_one = User.create(name: 'First name', email: 'first@email.com', confirmed: 'true')
          user_two = User.create(name: 'Second name', email: 'second@email.com', confirmed: 'true')

          get '/exports?users=true'

          expect(CSV.parse(last_response.body)).to eql(CSV.parse(user_one.as_csv+user_two.as_csv))
        end
      end
    end
  end
end
