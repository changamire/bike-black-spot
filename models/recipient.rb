class Recipient < ActiveRecord::Base
	has_many :reports

  before_create :generate_uuid
	
	DEFAULT_MESSAGE="RECIPIENT_MESSAGE"
  def show_message
    "RECIPIENT_MESSAGE"
  end

  private
  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
