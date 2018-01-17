class AchievableOption < Option
  def self.all # rubocop:disable Metrics/MethodLength
    [
      new('cv_completed', I18n.t('advisors.achievement.cv.task')),
      new('job_application', I18n.t('advisors.achievement.job.task')),
      new('interview', I18n.t('advisors.achievement.interview.task')),
      new('placement_volunteering', I18n.t('advisors.achievement.placement.task')),
      new('training_started', I18n.t('advisors.achievement.training.task')),
      new('course_completed', I18n.t('advisors.achievement.course.task')),
      new('job_start', I18n.t('advisors.achievement.job_start.task')),
      new('job_sustained', I18n.t('advisors.achievement.job_sustained.task')),
      new('boc_completed', I18n.t('advisors.achievement.boc.task')),
      new('13_week_sustainment', I18n.t('advisors.achievement.13_week.task'))
    ]
  end
end