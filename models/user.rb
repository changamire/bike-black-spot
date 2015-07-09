class User < ActiveRecord::Base
	has_many :reports

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
