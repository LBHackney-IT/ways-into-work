class AchievementOption < Option
  attr_reader :icon

  def initialize(id, name, icon)
    super(id, name)
    @icon = icon
  end

  def self.all # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    [
      new('cv_completed', I18n.t('advisors.achievement.cv_completed.title.future'), 'file-pdf-o'),
      new('job_application', I18n.t('advisors.achievement.job_application.title.future'), 'paper-plane'),
      new('interview', I18n.t('advisors.achievement.interview.title.future'), 'street-view'),
      new('placement_volunteering', I18n.t('advisors.achievement.placement_volunteering.title.future'), 'handshake-o'),
      new('training_started', I18n.t('advisors.achievement.training_started.title.future'), 'book'),
      new('course_completed', I18n.t('advisors.achievement.course_completed.title.future'), 'graduation-cap'),
      new('job_start', I18n.t('advisors.achievement.job_start.title.future'), 'id-badge'),
      new('job_sustained', I18n.t('advisors.achievement.job_sustained.title.future'), 'shield'),
      # new('boc_completed', I18n.t('advisors.achievement.boc_completed.title.future'), 'money'),
      # new('13_week_sustainment', I18n.t('advisors.achievement.13_week_sustainment.title.future'), 'shield')
    ]
  end
end
