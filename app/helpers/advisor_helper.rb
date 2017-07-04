module AdvisorHelper
  def number_of_days_waiting(date)
    if(date != Date.today)
      return " - waiting #{pluralize((Date.today - date).to_i, 'day')}"
    else
      return " - today"
    end
  end
end
