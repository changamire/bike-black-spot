class Category < ActiveRecord::Base
	has_many :reports
  before_create :generate_uuid


	DEFAULT_MESSAGE='CATEGORY_MESSAGE'
  def show_message
    'CATEGORY_MESSAGE'
  end

  private
  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
	
