class Achievement < ApplicationRecord
  belongs_to :client
  belongs_to :action_plan_task # optional

  scope :with_name, ->(name) { where(name: name) }
  scope :achieved_in_period, ->(from, to) { where('created_at BETWEEN ? AND ?', from, to) }
end
