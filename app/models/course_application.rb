class CourseApplication < ApplicationRecord

  scope :awaiting_review, -> { where(dismissed: false).order(created_at: :desc) }
  scope :reviewed, -> { where(dismissed: true).order(created_at: :desc) }

  def total_applications
    CourseApplication.where(intake_id: self.intake_id).count
  end

end
