class Training < ApplicationRecord
  acts_as :opportunity

  validates :url, presence: true
end
