class AttachAchievementsToTasks < ActiveRecord::Migration[5.1]
  def change
    remove_column :action_plan_tasks, :achievement_name, :string
    add_reference :achievements, :action_plan_task, index: true
  end
end
