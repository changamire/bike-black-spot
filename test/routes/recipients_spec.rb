require_relative '../spec_helper'

describe 'Recipients' do

  describe 'Post /recipients' do

    params = {name: 'Fred',
              email: 'myemail@email.com',
              state: 'VIC'}
    it 'should return error if no auth' do
      post '/recipients?'
      expect(last_response.status).to be(401)
    end

    it 'should return error with incorrect params' do
      login_as :Admin

      post '/recipients', {name: 'Fred',
                           email: 'myemail@email.com',
                           state: 'Vic',
                           derp: 'fail'}
      expect(last_response.status).to be(400)
    end

    it 'should allow recipient creation' do
      login_as :Admin
      post '/recipients', params
      expect(Recipient.first['name']).to eq(params[:name])
    end

    it 'should allow duplicate recipients' do
      Recipient.create(params)

      login_as :Admin
      post '/recipients?', params

      expect(Recipient.count).to be(2)

    end
  end

  describe 'Get /recipients' do
    describe 'with no params' do
      describe 'while not authenticated' do
        it 'should return status 401' do
          get RoutingLocations::RECIPIENTS + '?uuid=24398358936'
          expect(last_response.status).to be(401)
        end
      end
      describe 'while authenticated' do
        before(:each) do
          login_as :Admin
        end
        it 'should return return status 200(OK)' do
          get RoutingLocations::RECIPIENTS
          expect(last_response).to be_ok
        end

        it 'should return return all recipients' do
          Recipient.create(name: 'Some Dude', email: 'some@dude.com', state: 'VIC')
          Recipient.create(name: 'Another Dude', email: 'another@dude.com', state: 'VIC')
          get RoutingLocations::RECIPIENTS
          recipients = JSON.parse(last_response.body)
          expect(recipients[0]['name']).to eq('Some Dude')
          expect(recipients[1]['name']).to eq('Another Dude')
        end
      end
    end

    describe 'with params' do
      describe 'while not authenticated' do
        it 'should return status 401' do
          get RoutingLocations::RECIPIENTS + '?uuid=24398358936'
          expect(last_response.status).to be(401)
        end
      end

      describe 'while authenticated' do
        before(:each) do
          login_as :Admin
        end

        describe 'should return status' do
          it '400 error when incorrect params' do
            get RoutingLocations::RECIPIENTS + '?uuid=doesntmatterfail&fail=fial'
            expect(last_response.status).to eq(400)
          end

          it '400 error when incorrect params' do
            get RoutingLocations::RECIPIENTS + '?fail=fial'
            expect(last_response.status).to eq(400)
          end
        end

        it 'should return correct recipient' do
          recipient = Recipient.create(name: 'Another Dude', email: 'another@dude.com', state: 'VIC')
          get RoutingLocations::RECIPIENTS + "?uuid=#{recipient.uuid}"
          response = JSON.parse(last_response.body)
          expect(response['name']).to eq(recipient.name)
        end
        it 'should return null when no recipient' do
          get RoutingLocations::RECIPIENTS + '?uuid=12345'
          response = last_response.body
          expect(response).to eq('null')
        end
      end
    end
  end

  describe 'Delete /recipients' do
    describe 'while not authenticated' do
      it 'should return error if no auth' do
        delete '/recipients?uuid=thisdoesntreallymatter'
        expect(last_response.status).to be(401)
      end
    end
    describe 'while authenticated' do
      before(:each) do
        login_as :Admin
      end

      describe 'should return status' do
        it '400 with incorrect params' do
          delete '/recipients?uuid=sothisisathing&fail=fial'
          expect(last_response.status).to be(400)
        end
        it '400 with no params' do
          delete '/recipients?'
          expect(last_response.status).to be(400)
        end

        it '400 when uuid not found' do
          delete '/recipients?uuid=23423423'
          expect(last_response.status).to be(400)
        end
      end

      it 'should delete correct recipient' do
        recipient = Recipient.create(name: 'Another Dude', email: 'another@dude.com', state: 'VIC')
        delete "/recipients?uuid=#{recipient.uuid}"

        expect(last_response.status).to be(204)
        expect(Recipient.first).to be_nil
      end
    end
  end
end
