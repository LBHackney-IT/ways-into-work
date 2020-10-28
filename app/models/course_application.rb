class CourseApplication < Application

  scope :awaiting_review, -> { where(dismissed: false).order(created_at: :desc) }
  scope :reviewed, -> { where(dismissed: true).order(created_at: :desc) }

  def total_applications
    CourseApplication.where(intake_id: self.intake_id).count
  end

  def self.to_csv(intakes)
    CSV.generate(headers: true) do |csv|
      course_application_attributes = self.attribute_names
      header = course_application_attributes += ["course_title", "intake_dates"]
      csv << header
      all.each do |ca|
        row = attribute_names.map{ |attr| ca.send(attr) }
        intake = intakes.select{ |intake| intake["id"] == ca.intake_id }.first
        if intake.present?
          course_title = intake["acf"]["parent_course"]["post_title"]
          intake_dates = "#{intake["acf"]["start_date"]} - #{intake["acf"]["end_date"]}"
        else
          course_title = "Intake not found"
          intake_dates = "Intake not found"
        end
        row += [course_title, intake_dates]
        csv << row
      end
    end
  end

end
