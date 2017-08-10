class AddActionPlanTaskOutcome < ActiveRecord::Migration[5.1]
  def change
    add_column :action_plan_tasks, :outcome, :string
  end
end
