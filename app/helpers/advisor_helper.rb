module AdvisorHelper
  
  LEADER_NAMES = {
    'Hoxton Hub' => 'Mohammed Jama',
    'Woodberry Down Hub' => 'Caroline Modest',
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
end
