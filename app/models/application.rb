class Application < ApplicationRecord

  scope :awaiting_review, -> { where(dismissed: false).order(created_at: :desc) }
  scope :reviewed, -> { where(dismissed: true).order(created_at: :desc) }

  def total_applications
    Application.where(wordpress_object_id: self.wordpress_object_id).count
  end

  def type_as_parameter
    case type
    when 'CourseApplication'
      'course'
    when 'VacancyApplication'
      'vacancy'
    end
  end

end