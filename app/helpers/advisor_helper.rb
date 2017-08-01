module AdvisorHelper
  LEADER_NAMES = {    
    'Hoxton Opportunity Hub' => 'Mohammed Jama',    
    'Redmond Community Centre' => 'Caroline Modest',    
    'Homerton Library' => 'Dujon Harvey'  
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
