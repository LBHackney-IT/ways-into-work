class ExternalApprenticeship < ApplicationRecord
  include Opportunity

  validates :title, presence: true
  validates :end_date, presence: true
  validates :short_description, presence: true
  validates :location, presence: true
  validates :salary, presence: true

  has_many :enquiries, as: :opportunity

  scope :active, -> { where('end_date >= ?', Date.today) }

end