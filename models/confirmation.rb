require 'SecureRandom'
class Confirmation < ActiveRecord::Base

  before_create :generate_token

  validates :user, presence: true
  validates :user, format: { with: /[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}/,
                              message: 'Must be a valid user uuid.'}

  def generate_token
    self.token = SecureRandom.uuid
  end
end

