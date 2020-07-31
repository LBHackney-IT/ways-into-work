class AddFeedbackToCourseApplications < ActiveRecord::Migration[5.1]
  def change
    add_column :course_applications, :feedback, :text
  end
end
