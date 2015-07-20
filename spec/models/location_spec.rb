require_relative '../spec_helper'

describe 'Location' do

  params = {}

  before(:each) do
    params = {
        lat: '-32.930768',
        long: '151.768123',
        number: '63',
        street: 'Bull Street',
        suburb: 'Cooks Hill',
        state: 'NSW',
        postcode: '2300',
        country: 'Australia',
        formatted_address: '63 Bull Street, Cooks Hill NSW 2300, Australia'
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
    it 'should fail if no street' do
      params.delete(:street)
      location = Location.create(params)
      expect(location.valid?).to be_falsey
    end
    it 'should fail if no suburb' do
      params.delete(:suburb)
      location = Location.create(params)
      expect(location.valid?).to be_falsey
    end
    it 'should fail if no state' do
      params.delete(:state)
      location = Location.create(params)
      expect(location.valid?).to be_falsey
    end
    it 'should fail if no postcode' do
      params.delete(:postcode)
      location = Location.create(params)
      expect(location.valid?).to be_falsey
    end
    it 'should fail if no country' do
      params.delete(:country)
      location = Location.create(params)
      expect(location.valid?).to be_falsey
    end

  end
end
