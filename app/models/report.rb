require_relative '../helpers/image_upload'

class Report < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :location

  has_many :recipient

  validates :user, :category, :location, presence: true
  validates :description, length: {maximum: 500}

  before_create :generate_uuid

  @fields_that_require_auth = %w(user_uuid updated_at sent_at)

  def self.json(authorised)
    result = []
    Report.all.each do |report|
      reportHash = JSON.parse(report.to_json)
      reportHash.delete('id')
      Category.ID_to_name_hash(reportHash, report['category_id'])
      User.ID_to_UUID_hash(reportHash, report['user_id'])
      Location.object_to_lat_long_address(reportHash, report['location_id'])

      unless authorised
        reportHash = reportHash.reject { |key| @fields_that_require_auth.include?(key) }
      end
      result.push(reportHash)
    end
    return result.to_json
  end

  def generate_uuid
    self.uuid = SecureRandom.uuid

    unless image.nil?
      url = ImageUpload.upload_base64(image,uuid)
      self.image = url
    end
  end

  def requires_auth?(field)
    puts "hitting here" + field
    # @fields_that_require_auth.include?(field)
    [:user, :category].include?(field)
  end
end
