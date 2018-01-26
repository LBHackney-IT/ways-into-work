module AchievementHelper
  
  def achievement_title(id, count)
    first_or_subsequent = count == 1 ? 'first' : 'subsequent'
    I18n.t("advisors.achievement.#{id}.title.#{first_or_subsequent}", count: count)
  end
  
  def achievement_icon(id)
    fa_icon icon_list[id]
  end
  
  def icon_list # rubocop:disable Metrics/MethodLength
    {
      'cv_completed' => 'file-pdf-o',
      'job_application' => 'paper-plane',
      'interview' => 'street-view',
      'placement_volunteering' => 'handshake-o',
      'training_started' => 'graduation-cap',
      'course_completed' => 'graduation-cap',
      'job_start' => 'id-badge',
      'job_sustained' => 'shield',
      'boc_completed' => 'money',
      '13_week_sustainment' => 'shield'
    }
  end
  
end
