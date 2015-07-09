class User < ActiveRecord::Base
	has_many :reports
  validates :name, :email, presence: true
  validates :name, format: { with: /\A[a-zA-Z\-'\s]{0,32}\Z/,
                 message: 'Must contain letters only and under 32 chars'}

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
                  message: 'Must be a valid email.'}
  validates :postcode, format: {with: /(\A\Z)|(\A[0-9]{4}\Z)/,
                     message: 'Must be a valid postcode'}
  before_create :generate_uuid

	DEFAULT_MESSAGE="USER_MESSAGE"
  def show_message
    "USER_MESSAGE"
  end

  private
  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
