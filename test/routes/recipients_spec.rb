require_relative '../spec_helper'

describe 'Recipients' do

  describe 'Get from /recipients' do

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
end
