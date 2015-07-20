class Location < ActiveRecord::Base
  validates :lat, :long, :street, :suburb, :state, :postcode, :country, presence: true

  before_create :generate_uuid

  private
  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end