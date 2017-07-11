class ActionPlanTask < ApplicationRecord

  validates :due_date, :title, :client, presence: true

  enum status: [ :ongoing, :completed ]

  belongs_to :client
  belongs_to :advisor #optional

  before_save :check_completion

  def task_owner_name
    (advisor || client).name
  end

  def check_completion
    self.ended_at = (self.completed? ? Time.now : nil)
  end

end
