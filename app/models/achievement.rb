class Achievement < ApplicationRecord
  belongs_to :client
  
  scope :with_name, ->(name) { where(name: name) }
  scope :acheived_in_period, ->(from, to) { where('date_acheived BETWEEN ? AND ?', from, to) }
end
