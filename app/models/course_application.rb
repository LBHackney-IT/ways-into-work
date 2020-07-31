class CourseApplication < ApplicationRecord

  scope :awaiting_review, -> { where("status is NUll").order(created_at: :desc) }
  scope :reviewed, -> { where("status is not NUll").order(created_at: :desc) }

  def total_applications
    CourseApplication.where(intake_id: self.intake_id).count
  end

  def accepted_applications
    CourseApplication.where(intake_id: self.intake_id, status: 'accepted').count
  end
end
