class CourseApplication < ApplicationRecord

  def intake
    response = HTTParty.get("https://hackney-works-staging.hackney.gov.uk/wp-json/wp/v2/intake/#{intake_id}").parsed_response
  end
  def total_applications
    CourseApplication.where(intake_id: self.intake_id).count
  end

  def accepted_applications
    CourseApplication.where(intake_id: self.intake_id, status: 'accepted').count
  end
end
