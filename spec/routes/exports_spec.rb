describe 'Exports' do
  describe 'get' do
    describe '/exports/users' do

      describe 'when not logged in' do
        describe 'should return status' do
          it '401 given users' do
            get '/exports/users'
            expect(last_response.status).to be(401)
          end
          it '400 when given unknown params' do
            get '/exports/users?hello=true'
            expect(last_response.status).to be(400)
          end
        end
      end
      describe 'when logged in' do
        before(:each) do
          login_as :Admin
        end
        it 'should return status 200 when logged in' do
          get '/exports/users'
          expect(last_response.status).to be(200)
        end
      end
    end
    describe '/exports/reports' do
      describe 'when not logged in' do
        describe 'should return status' do
          it '401 given users' do
            get '/exports/reports'
            expect(last_response.status).to be(401)
          end
          it '400 when given unknown params' do
            get '/exports/reports?hello=true'
            expect(last_response.status).to be(400)
          end
        end
      end
      describe 'when logged in' do
        before(:each) do
          login_as :Admin
        end
        it 'should return status 200 when logged in' do
          get '/exports/reports'
          expect(last_response.status).to be(200)
        end
      end
    end
  end
end
