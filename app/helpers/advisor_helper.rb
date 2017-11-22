module AdvisorHelper
  LEADER_NAMES = {
    'Opportunity Hub, Hoxton' => 'Mohammed Jama',
    'Redmond Community Centre' => 'Caroline Modest',
    'Homerton Library' => 'Dujon Harvey',
    'Supported Employment' => 'Anna-Renee Paisley'
  }


  def number_of_days_waiting(date)
    if(date != Date.today)
      " - waiting #{pluralize((Date.today - date).to_i, 'day')}"
    else
      " - today"
    end
  end

  def team_leader_name(hub_name)
    LEADER_NAMES[hub_name]
  end

end
