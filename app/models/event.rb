class Event < ApplicationRecord
  acts_as :opportunity

  validates :url, presence: true
end
