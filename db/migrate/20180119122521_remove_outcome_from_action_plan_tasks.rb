class RemoveOutcomeFromActionPlanTasks < ActiveRecord::Migration[5.1]
  def change
    remove_column :action_plan_tasks, :outcome, :string
  end
end
