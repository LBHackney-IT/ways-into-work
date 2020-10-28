class Application < ApplicationRecord
  def type_as_parameter
    case type
    when 'CourseApplication'
      'course'
    when 'VacancyApplication'
      'vacancy'
    end
  end
  # scope :awaiting_review, -> { where(dismissed: false).order(created_at: :desc) }
  # scope :reviewed, -> { where(dismissed: true).order(created_at: :desc) }

  # def total_applications
  #   where(intake_id: self.intake_id).count
  # end
end