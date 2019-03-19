class Job < ApplicationRecord
  include Opportunity

  validates :title, presence: true
  validates :end_date, presence: true
  validates :short_description, presence: true

  has_many :enquiries, as: :opportunity

end