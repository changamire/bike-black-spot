class Report < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  has_many :recipient

  validates :user, :category, :lat, :long, presence: true
  validates :description, length: {maximum: 500}
  validates :lat, numericality: {less_than_or_equal_to: 90}
  validates :lat, numericality: {greater_than_or_equal_to: -90}
  validates :long, numericality: {less_than_or_equal_to: 180}
  validates :long, numericality: {greater_than_or_equal_to: -180}

  before_create :generate_uuid

  @fields_that_require_auth = []

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end

  def self.requires_auth(field)
    @fields_that_require_auth.include?(field)
  end
end
