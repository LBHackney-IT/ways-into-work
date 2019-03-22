class Job < ApplicationRecord
  acts_as :opportunity

  validates :pay, presence: true
  validates :contract, presence: true
  validates :sector, presence: true
  validates :full_description, presence: true

  has_many :enquiries, as: :opportunity

end
