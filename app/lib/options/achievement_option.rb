class AchievementOption < Option
  attr_reader :icon

  def initialize(id, name, icon)
    super(id, name)
    @icon = icon
  end

  def self.group_by_option(achievements)
    achievements.each_with_object({}) do |achievement, options_group|
      if (opt = find(achievement.name)).present?
        options_group[opt] = (options_group[opt] || []) << achievement
      end
    end
  end

  def self.all
    OPTIONS
  end

  OPTIONS = [
    new('cv_completed', I18n.t('advisors.achievement.cv_completed.title.future'), 'file-pdf-o'),
    new('job_application', I18n.t('advisors.achievement.job_application.title.future'), 'paper-plane'),
    new('interview', I18n.t('advisors.achievement.interview.title.future'), 'street-view'),
    new('placement_volunteering', I18n.t('advisors.achievement.placement_volunteering.title.future'), 'handshake-o'),
    new('training_started', I18n.t('advisors.achievement.training_started.title.future'), 'book'),
    new('course_completed', I18n.t('advisors.achievement.course_completed.title.future'), 'graduation-cap'),
    new('job_start', I18n.t('advisors.achievement.job_start.title.future'), 'id-badge'),
    new('job_sustained', I18n.t('advisors.achievement.job_sustained.title.future'), 'shield')
  ].freeze
end
