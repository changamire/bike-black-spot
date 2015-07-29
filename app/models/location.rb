require 'geokit'

class Location < ActiveRecord::Base
  validates :lat, :long, presence: true

  validates :lat, numericality: {less_than: 90}
  validates :lat, numericality: {greater_than: -90}
  validates :long, numericality: {less_than: 180}
  validates :long, numericality: {greater_than: -180}

  before_create :generate_uuid
  after_create :geocode

  def self.object_to_lat_long_address(hash, location)
    hash['latitude'] = Location.find(location).lat
    hash['longitude'] = Location.find(location).long
    hash['address'] = Location.find(location).formatted_address
    hash.delete('location_id')
  end

  private
  def generate_uuid
    self.uuid = SecureRandom.uuid
  end

  def geocode
    # return
    @result = call_geocoder
    if @result.nil?
      self.formatted_address = 'Address unavailable.'
    else
      self.number = @result.street_number
      self.street = @result.street_name
      self.suburb = @result.city
      self.state = @result.state_code
      self.postcode = @result.zip
      self.country = @result.country
      self.formatted_address = @result.full_address
    end
    self.save!
  end

  def call_geocoder
    begin
      Geokit::Geocoders::request_timeout = 3
      Geokit::Geocoders::provider_order = [:google, :bing]

      # Disable HTTPS globally.  This option can also be set on individual
      # geocoder classes.
      Geokit::Geocoders::secure = false

      # Control verification of the server certificate for geocoders using HTTPS
      Geokit::Geocoders::ssl_verify_mode = OpenSSL::SSL::VERIFY_NONE

      @latlong = "#{self.lat}, #{self.long}"
      Geokit::Geocoders::MultiGeocoder.reverse_geocode(@latlong)
    rescue
      return nil
    end
  end
end
