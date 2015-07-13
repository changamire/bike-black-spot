require_relative '../spec_helper'

describe 'Recipients' do

  describe 'Get from /recipients' do

    describe 'with no params' do
      it 'should return return status 200(OK)' do
        get RoutingLocations::RECIPIENTS
        expect(last_response).to be_ok
      end

      it 'should return return all recipients' do
        Recipient.create(name: 'Some Dude', email: 'some@dude.com', lat: '37.8136', long: '144.9631')
        Recipient.create(name: 'Another Dude', email: 'another@dude.com', lat: '144.9631', long: '37.8136')
        get RoutingLocations::RECIPIENTS
        recipients = JSON.parse(last_response.body)
        expect(recipients[0]['name']).to eq('Some Dude')
        expect(recipients[1]['name']).to eq('Another Dude')
      end
    end

    describe 'with params' do

      it 'should return correct recipient' do
        recipient = Recipient.create(name: 'Another Dude', email: 'another@dude.com', lat: '144.9631', long: '37.8136')
        get RoutingLocations::RECIPIENTS + "?uuid=#{recipient.uuid}"
        response = JSON.parse(last_response.body)
        expect(response['name']).to eq(recipient.name)
      end

      it 'should return 500 error when incorrect params' do
        get RoutingLocations::RECIPIENTS + '?uuid=doesntmatterfail&fail=fial'
        expect(last_response.status).to eq(500)
      end

      it 'should return 500 error when incorrect params' do
        get RoutingLocations::RECIPIENTS + '?fail=fial'
        expect(last_response.status).to eq(500)
      end

    end
  end
end
