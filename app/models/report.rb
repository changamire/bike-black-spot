class Report < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  has_many :recipient

  validates :user, :category, :lat, :long, presence: true
  validates :description, length: {maximum: 500}
  validates :lat, numericality: {less_than_or_equal_to: 90}
  validates :lat, numericality: {greater_than_or_equal_to: -90}
  validates :long, numericality: {less_than_or_equal_to: 180}
  validates :long, numericality: {greater_than_or_equal_to: -180}

  before_create :generate_uuid

  @fields_that_require_auth = %w(user_uuid updated_at sent_at)

  def self.json(authorised)
    result = []
    Report.all.each do |report|
      reportHash = JSON.parse(report.to_json)
      reportHash.delete('id')
      Category.ID_to_name_hash(reportHash, report['category_id'])
      User.ID_to_UUID_hash(reportHash, report['user_id'])
      unless authorised
        reportHash = reportHash.reject { |key| @fields_that_require_auth.include?(key) }
      end
      result.push(reportHash)
    end
    return result.to_json
  end

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end

  def requires_auth?(field)
    puts "hitting here" + field
    # @fields_that_require_auth.include?(field)
    [:user, :category].include?(field)
  end
end
