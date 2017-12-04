module ActionPlanTaskHelpers
  
  def check_action_plan(task, status)
    selector = ".action-section.#{status} #action_plan_task_#{task.id}"
    expect(page).to have_css(selector)
    within selector do
      expect(page).to have_content(task.title)
      if status == 'completed'
        expect(page).to have_content(task.ended_at.strftime('%d %b'))
      else
        expect(page).to have_content(task.due_date.strftime('%d %b'))
      end
    end
  end
  
end

World(ActionPlanTaskHelpers)
