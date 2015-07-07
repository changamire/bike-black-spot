class User < ActiveRecord::Base
	has_many :reports
	
	DEFAULT_MESSAGE="USER_MESSAGE"
  def show_message
    "USER_MESSAGE"
  end
end
