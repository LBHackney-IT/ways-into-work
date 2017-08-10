class CreateActionPlanTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :action_plan_tasks do |t|
      t.string :title
      t.text :notes
      t.integer :status, default: ActionPlanTask::statuses[:ongoing]
      t.datetime :ended_at
      t.datetime :due_date
      t.belongs_to :client, index: true
      t.belongs_to :advisor, index: true
      t.timestamps
    end
  end
end
