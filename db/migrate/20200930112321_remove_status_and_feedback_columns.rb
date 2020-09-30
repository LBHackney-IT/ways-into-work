class RemoveStatusAndFeedbackColumns < ActiveRecord::Migration[5.1]
  def change
    remove_column :course_applications, :status
    remove_column :course_applications, :feedback
  end
end
