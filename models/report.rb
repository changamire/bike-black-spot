class Report < ActiveRecord::Base
	belongs_to :user
	belongs_to :recipient
	belongs_to :category


	DEFAULT_MESSAGE="REPORT_MESSAGE"
  def show_message
    "REPORT_MESSAGE"
  end
end
