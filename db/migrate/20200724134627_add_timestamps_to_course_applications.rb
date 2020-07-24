class AddTimestampsToCourseApplications < ActiveRecord::Migration[5.1]
  def change
    add_column :course_applications, :created_at, :datetime, null: false
    add_column :course_applications, :updated_at, :datetime, null: false
  end
end
