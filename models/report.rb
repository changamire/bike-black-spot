require 'SecureRandom'

class Report < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipient
  belongs_to :category
  validates :lat, :long, presence: true
  validates :description, length: {maximum: 500}
  validates :lat, numericality: {less_than_or_equal_to: 90}
  validates :lat, numericality: {greater_than_or_equal_to: -90}
  validates :long, numericality: {less_than_or_equal_to: 180}
  validates :long, numericality: {greater_than_or_equal_to: -180}

  before_create :generate_uuid

  DEFAULT_MESSAGE="REPORT_MESSAGE"

  def show_message
    "REPORT_MESSAGE"
  end

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
