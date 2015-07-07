class Category < ActiveRecord::Base
	has_many :reports
	
	DEFAULT_MESSAGE="CATEGORY_MESSAGE"
  def show_message
    "CATEGORY_MESSAGE"
  end
end
	
