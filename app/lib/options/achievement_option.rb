class AchievementOption < Option
  attr_reader :icon

  def initialize(id, name, icon)
    super(id, name)
    @icon = icon
  end

  def self.all # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    [
      new('cv_completed', I18n.t('advisors.achievement.cv_completed.achieved'), 'file-pdf-o'),
      new('job_application', I18n.t('advisors.achievement.job_application.achieved'), 'paper-plane'),
      new('interview', I18n.t('advisors.achievement.interview.achieved'), 'street-view'),
      new('placement_volunteering', I18n.t('advisors.achievement.placement_volunteering.achieved'), 'handshake-o'),
      new('training_started', I18n.t('advisors.achievement.training_started.achieved'), 'graduation-cap'),
      new('course_completed', I18n.t('advisors.achievement.course_completed.achieved'), 'graduation-cap'),
      new('job_start', I18n.t('advisors.achievement.job_start.achieved'), 'id-badge'),
      new('job_sustained', I18n.t('advisors.achievement.job_sustained.achieved'), 'shield'),
      new('boc_completed', I18n.t('advisors.achievement.boc_completed.achieved'), 'money'),
      new('13_week_sustainment', I18n.t('advisors.achievement.13_week_sustainment.achieved'), 'shield')
    ]
  end
end
