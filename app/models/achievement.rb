class Achievement < ApplicationRecord
  belongs_to :client

  scope :with_name, ->(name) { where(name: name) }
  scope :achieved_in_period, ->(from, to) { where('created_at BETWEEN ? AND ?', from, to) }
end
