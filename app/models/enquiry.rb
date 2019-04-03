class Enquiry < ApplicationRecord
  belongs_to :client
  belongs_to :opportunity

  has_one :file_upload

  validates :status, presence: true

  enum status: %i[awaiting accepted unsuccessful]

  scope :awaiting, -> { where('status = 0').order(:created_at) }
  scope :reviewed, -> { where('status != 0').order(:created_at) }

  scope :jobs, -> { joins(:opportunity).where(opportunities: { actable_type: 'Job'} ) }
  scope :apprenticeships, -> { joins(:opportunity).where(opportunities: { actable_type: 'ExternalApprenticeship'} ) }
  scope :placements, -> { joins(:opportunity).where(opportunities: { actable_type: 'WorkPlacement'} ) }
end
