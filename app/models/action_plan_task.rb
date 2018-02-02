class ActionPlanTask < ApplicationRecord
  validates :due_date, :title, :client, presence: true

  enum status: %i[ongoing completed]

  belongs_to :client
  belongs_to :advisor # optional

  before_save :check_completion
  after_save :award_achievement
  
  scope :completed, -> { where(status: 'completed') }

  def task_owner_name
    (advisor || client).name
  end

  def check_completion
    self.ended_at = (completed? ? Time.zone.now : nil)
  end
  
  def award_achievement
    return unless completed? && achievement_name.present?
    client.achievements.create(name: achievement_name)
  end
end
