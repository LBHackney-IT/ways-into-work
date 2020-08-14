module CourseApplicationHelper
  def intake(intakes, intake_id)
    intakes.select { |intake| intake["id"] == intake_id }.try(:first)
  end

  def intake_as_dates(intakes, intake_id)
    if intake = intake(intakes, intake_id)

      if intake["acf"]["end_date"].to_date
        "#{intake["acf"]["start_date"].to_date.strftime("%b %Y")}—#{intake["acf"]["end_date"].to_date.strftime("%b %Y")}"
      else
        "From #{intake["acf"]["start_date"].to_date.strftime("%b %Y")}"
      end

    else
      "Intake not found"
    end
  end

end
