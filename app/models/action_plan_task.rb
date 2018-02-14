class ActionPlanTask < ApplicationRecord
  validates :due_date, :title, :client, presence: true

  enum status: %i[ongoing completed]

  belongs_to :client
  belongs_to :advisor # optional
  has_one :achievement, dependent: :destroy

  before_save :check_completion, :award_achievement
  after_save  :remove_achievement

  scope :completed, -> { where(status: 'completed') }

  def task_owner_name
    (advisor || client).name
  end

  def check_completion
    self.ended_at = (completed? ? Time.zone.now : nil)
  end

  def award_achievement
    return unless completed?
    return if (achievement = AchievementOption.named(title)).blank?
    build_achievement(name: achievement.id, client: client)
  end

  def remove_achievement
    return if completed?
    achievement&.destroy
  end
end
