class AchievementOption < Option
  def self.all # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    [
      new('cv_completed', I18n.t('advisors.achievement.cv_completed.manual')),
      new('job_application', I18n.t('advisors.achievement.job_application.manual')),
      new('interview', I18n.t('advisors.achievement.interview.manual')),
      new('placement_volunteering', I18n.t('advisors.achievement.placement_volunteering.manual')),
      new('training_started', I18n.t('advisors.achievement.training_started.manual')),
      new('course_completed', I18n.t('advisors.achievement.course_completed.manual')),
      new('job_start', I18n.t('advisors.achievement.job_start.manual')),
      new('job_sustained', I18n.t('advisors.achievement.job_sustained.manual')),
      new('boc_completed', I18n.t('advisors.achievement.boc_completed.manual')),
      new('13_week_sustainment', I18n.t('advisors.achievement.13_week_sustainment.manual'))
    ]
  end
end
