class Recipient < ActiveRecord::Base
	has_many :reports
	
	DEFAULT_MESSAGE="RECIPIENT_MESSAGE"
  def show_message
    "RECIPIENT_MESSAGE"
  end
end
