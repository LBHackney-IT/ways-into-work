class Application < ApplicationRecord

  has_one :file_upload

  scope :awaiting_review, -> { where(dismissed: false).order(created_at: :desc) }
  scope :reviewed, -> { where(dismissed: true).order(created_at: :desc) }

  def title
    if type == 'CourseApplication'
      byebug
      get_object_by_id(type, wordpress_object_id)
    elsif type == 'VacancyApplication'
    end
  end

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