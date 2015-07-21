class Location < ActiveRecord::Base
  validates :lat, :long, presence: true

  before_create :generate_uuid
  after_create :geocode

  def self.object_to_lat_long(hash, location)
    hash['latitude'] = Location.find(location).lat
    hash['longitude'] = Location.find(location).long
    hash.delete('location_id')
  end

  private
  def generate_uuid
    self.uuid = SecureRandom.uuid
  end

  def geocode
    return if ENV['RACK_ENV'] == 'test'
    @latlong = "#{self.lat}, #{self.long}"
    @result = Geokit::Geocoders::GoogleGeocoder.reverse_geocode(@latlong)
    self.number = @result.street_number
    self.street = @result.street_name
    self.suburb = @result.city
    self.state = @result.state_code
    self.postcode = @result.zip
    self.country = @result.country
    self.formatted_address = @result.full_address
  end
end