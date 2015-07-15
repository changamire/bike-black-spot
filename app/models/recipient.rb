class Recipient < ActiveRecord::Base
  validates :name, :email, :state, presence: true
  validates :name, format: {with: /\A.(?!\s*$).{1,32}\Z/,
                            message: 'Must be under 32 chars'}

  validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
                             message: 'Must be a valid email.'}
  validates :state, inclusion: { in: %w(VIC NSW QLD NT WA SA TAS ACT)}
	has_many :reports

  before_create :generate_uuid

  private
  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
