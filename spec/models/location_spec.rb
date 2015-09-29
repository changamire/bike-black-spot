require_relative '../spec_helper'
describe 'Location' do


  params = {}
  location = {}

  mocked_location = OpenStruct.new
  mocked_location.street_number = '1'
  mocked_location.street_name = 'mocked_name'
  mocked_location.city = 'mocked_suburb'
  mocked_location.state_code = 'VICMocked'
  mocked_location.zip = '1234'
  mocked_location.country = 'Australia'
  mocked_location.full_address = mocked_location.street_number + ' ' + mocked_location.street_name + ' ' + mocked_location.city +
      ', ' + mocked_location.state_code + ', ' + mocked_location.zip + ', ' + mocked_location.country


  before(:each) do
    params = {
        lat: '-37.8165501',
        long: '144.9638398'
    }

    allow_any_instance_of(Location).to receive(:call_geocoder).and_return(mocked_location)

    location = Location.create(params)
  end

  describe 'generate_uuid' do
    it 'Should set a valid uuid' do
      expect(location.uuid).to match(/[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}/)
    end
  end

  describe 'create' do
    it 'should save to db' do
      expect(Location.first.uuid).to eq(location.uuid)
    end
  end

  describe 'validation of' do
    describe 'latitude' do
      it 'should fail if not given' do
        params.delete(:lat)
        location = Location.create(params)
        expect(location.valid?).to be_falsey
      end
      it 'should fail if given 91 or higher' do
        params[:lat] = 91
        location = Location.create(params)
        expect(location.valid?).to be_falsey
      end
      it 'should fail if given -91 or lower' do
        params[:lat] = -91
        location = Location.create(params)
        expect(location.valid?).to be_falsey
      end
      it 'should be valid given between -90 and 90' do
        params[:lat] = -5
        location = Location.create(params)
        expect(location.valid?).to be_truthy
      end
    end
    describe 'longitude' do
      it 'should fail if no long' do
        params.delete(:long)
        location = Location.create(params)
        expect(location.valid?).to be_falsey
      end
      it 'should fail if given 181 or higher' do
        params[:long] = 191
        location = Location.create(params)
        expect(location.valid?).to be_falsey
      end
      it 'should fail if given -181 or lower' do
        params[:long] = -191
        location = Location.create(params)
        expect(location.valid?).to be_falsey
      end
      it 'should be valid given between -180 and 180' do
        params[:long] = -5
        location = Location.create(params)
        expect(location.valid?).to be_truthy
      end
    end
  end
end

describe 'geocode location' do
  location = Location.create({lat: '-37.8165501',
                              long: '144.9638398'})
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
    expect(location.formatted_address).to eq('303 Collins St, Melbourne VIC 3000, Australia')
  end
end

