class CourseApplication < Application

  def self.to_csv(intakes)
    CSV.generate(headers: true) do |csv|
      course_application_attributes = self.attribute_names
      header = course_application_attributes += ["course_title", "intake_dates"]
      csv << header
      all.each do |ca|
        row = attribute_names.map{ |attr| ca.send(attr) }
        intake = intakes.select{ |intake| intake["id"] == ca.wordpress_object_id }.first
        if intake.present?
          course_title = intake["acf"] && intake["acf"]["parent_course"] && intake["acf"]["parent_course"]["post_title"]
          intake_dates = "#{intake["acf"] && intake["acf"]["start_date"]} - #{intake["acf"] && intake["acf"]["end_date"]}"
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
