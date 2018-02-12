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
    return unless completed?
    return if (achievement = AchievementOption.find_by_name(title)).blank?
    client.achievements.create(name: achievement.id, action_plan_task_id: id)
  end

  # def remove_achievement
  #   TODO - now achievement is tied to tasks we should be able to remove on transition to ongoing
  #   return unless completed? && AchievementOption.find_by_name(title).present?
  #   client.achievements.where(name: title).first.destroy
  # end
end
