class Enquiry < ApplicationRecord
  belongs_to :client
  belongs_to :opportunity

  validates :status, presence: true

  enum status: %i[awaiting accepted declined]

  scope :awaiting, -> { where('status = 0').order(:created_at) }
  scope :reviewed, -> { where('status != 0').order(:created_at) }

end
