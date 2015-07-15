require 'csv'
class User < ActiveRecord::Base
  has_many :reports
  validates :name, :email, presence: true
  validates :name, format: {with: /\A.(?!\s*$).{1,32}\Z/,
                            message: 'Must be under 32 chars'}

  validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
                             message: 'Must be a valid email.'}
  validates :postcode, format: {with: /(\A\Z)|(\A[0-9]{4}\Z)/,
                                message: 'Must be a valid postcode'}

  before_create :generate_uuid
  after_create  :create_confirmation


  def self.export
    result = ''
    User.all.each do |user|
      result+=(user.as_csv) if user.confirmed
    end
    return result
  end

  def as_csv
    # return ["#{self.name}, #{self.email}"].to_csv
    return [self.name, self.email].to_csv
  end

  private
  def generate_uuid
    self.uuid = SecureRandom.uuid
  end

  def create_confirmation
    Confirmation.create(user: self.uuid)
  end
end
