module AdvisorHelper
  LEADER_NAMES = {
    'Hoxton Hub' => 'Mohammed Jama',
    'Redmond Community Centre' => 'Caroline Modest',
    'Homerton Hub' => 'Dujon Harvey',
    'Supported Employment' => 'Anna-Renee Paisley'
  }.freeze

  def number_of_days_waiting(date)
    if date != Time.zone.today
      " - waiting #{pluralize((Time.zone.today - date).to_i, 'day')}"
    else
      ' - today'
    end
  end

  def opp_end_date(date)
    if Time.current.year == date.year
      date.strftime("%a %b #{date.day.ordinalize}")
    else
      date.strftime("%a %b #{date.day.ordinalize} %Y")
    end
  end
end
