class ActionPlanTasksDecorator < ApplicationDecorator
  decorates :action_plan_tasks

  def decorate_notes
    standard_wrapper('Notes', action_plan_tasks.notes)
  end
  
end
