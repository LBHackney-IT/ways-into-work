class AddDismissedColumnToCourseApplications < ActiveRecord::Migration[5.1]
  def change
    add_column :course_applications, :dismissed, :boolean, default: false
  end
end
