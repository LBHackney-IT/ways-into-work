class CourseApplication < ApplicationRecord
  def total_applications
    CourseApplication.where(intake_id: self.intake_id).count
  end

  def accepted_applications
    CourseApplication.where(intake_id: self.intake_id, status: 'accepted').count
  end
end
