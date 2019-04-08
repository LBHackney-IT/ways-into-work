class InternalApprenticeship < ApplicationRecord
  acts_as :opportunity

  validates :pay, presence: true
  validates :contract, presence: true
  validates :sector, presence: true
  validates :url, presence: true

end
