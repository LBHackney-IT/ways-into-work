class AddAchievementNameToActionPlanTask < ActiveRecord::Migration[5.1]
  def change
    add_column :action_plan_tasks, :achievement_name, :string
  end
end
