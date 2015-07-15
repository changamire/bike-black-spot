require 'json'

class Category < ActiveRecord::Base
  has_many :reports
  before_create :generate_uuid

  validates :name, presence: true

  def self.json
    result = []
    Category.all.each do |category|
      result.push(name: category[:name])
    end
    result.to_json
  end

  private
  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
	
