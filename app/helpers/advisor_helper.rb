module AdvisorHelper
  def number_of_days_waiting(date)
    if(date != Date.today)
      " - waiting #{pluralize((Date.today - date).to_i, 'day')}"
    else
      " - today"
    end
  end

end
