class ActionPlanTask < ApplicationRecord
  validates :due_date, :title, :client, presence: true

  enum status: %i[ongoing completed]

  belongs_to :client
  belongs_to :advisor # optional

  before_save :check_completion
  
  scope :completed, -> { where(status: 'completed') }
  scope :for_hub, ->(hub) { joins(:client).where('clients.advisor' => hub.advisors) }
  scope :completed_with_outcome, ->(outcome) { completed.where(outcome: outcome) }
  scope :ended_in_month, ->(date) { ended_in_period(date.beginning_of_month, date.end_of_month) }
  scope :ended_in_period, ->(from, to) { where('ended_at BETWEEN ? AND ?', from, to) }

  def task_owner_name
    (advisor || client).name
  end

  def check_completion
    self.ended_at = (completed? ? Time.zone.now : nil)
  end
end
