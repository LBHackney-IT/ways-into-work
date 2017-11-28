class AssessmentNote < ApplicationRecord
  validates :content_key, presence: true

  belongs_to :client

  validates :content_key, uniqueness: { scope: :client_id }
end
