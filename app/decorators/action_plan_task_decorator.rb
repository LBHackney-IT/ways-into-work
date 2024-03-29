class ActionPlanTaskDecorator < ApplicationDecorator
  decorates :action_plan_task

  def decorate_notes
    standard_wrapper('Notes:', action_plan_task.notes)
  end

  def decorate_title
    standard_wrapper('Task:', action_plan_task.title)
  end

  def decorate_due_date
    standard_wrapper('Due date:', action_plan_task.due_date.to_date.to_s(:short))
  end

  def decorate_action_completed_by
    standard_wrapper('Task to be completed by:', action_plan_task.task_owner_name)
  end
end
