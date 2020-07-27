class AddStatusToCourseApplications < ActiveRecord::Migration[5.1]
  def change
    add_column :course_applications, :status, :string
  end
end
