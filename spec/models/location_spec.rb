require_relative '../spec_helper'

xdescribe 'Location' do

  params = {}

  before(:each) do
    params = {
        lat: '-37.8165501',
        long: '144.9638398'
    }
  end

  describe 'generate_uuid' do
    it 'Should set a valid uuid' do
      location = Location.create(params)
      expect(location.uuid).to match(/[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}/)
    end
  end

  describe 'create' do
    it 'should save to db' do
      location = Location.create(params)
      expect(Location.first.uuid).to eq(location.uuid)
    end
  end

  describe 'validation' do
    it 'should fail if no lat' do
      params.delete(:lat)
      location = Location.create(params)
      expect(location.valid?).to be_falsey
    end
    it 'should fail if no long' do
      params.delete(:long)
      location = Location.create(params)
      expect(location.valid?).to be_falsey
    end
  end

  describe 'geocode' do
    let(:location) { Location.create(params) }
    it 'should set street number' do
      expect(location.number).to eq('303')
    end
    it 'should set street name' do
      expect(location.street).to eq('Collins Street')
    end
    it 'should set suburb' do
      expect(location.suburb).to eq('Melbourne')
    end
    it 'should set state' do
      expect(location.state).to eq('VIC')
    end
    it 'should set postcode' do
      expect(location.postcode).to eq('3000')
    end
    it 'should set country' do
      expect(location.country).to eq('Australia')
    end
    it 'should set formatted_address' do
      expect(location.formatted_address).to eq('303 Collins Street, Melbourne VIC 3000, Australia')
    end

  end
end
