class AchievementOption < Option
  def self.all # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    [
      new('cv_completed', I18n.t('advisors.achievement.cv.complete')),
      new('job_application', I18n.t('advisors.achievement.job.complete')),
      new('interview', I18n.t('advisors.achievement.interview.complete')),
      new('placement_volunteering', I18n.t('advisors.achievement.placement.complete')),
      new('training_started', I18n.t('advisors.achievement.training.complete')),
      new('course_completed', I18n.t('advisors.achievement.course.complete')),
      new('job_start', I18n.t('advisors.achievement.job_start.complete')),
      new('job_sustained', I18n.t('advisors.achievement.job_sustained.complete')),
      new('boc_completed', I18n.t('advisors.achievement.boc.complete')),
      new('13_week_sustainment', I18n.t('advisors.achievement.13_week.complete'))
    ]
  end
end
