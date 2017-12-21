class ActionPlanTask < ApplicationRecord
  validates :due_date, :title, :client, presence: true

  enum status: %i[ongoing completed]

  belongs_to :client
  belongs_to :advisor # optional

  before_save :check_completion

  def task_owner_name
    (advisor || client).name
  end

  def check_completion
    self.ended_at = (completed? ? Time.zone.now : nil)
  end
end
