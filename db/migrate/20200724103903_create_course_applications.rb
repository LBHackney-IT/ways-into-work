class CreateCourseApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :course_applications do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :email
      t.integer :intake_id
    end
  end
end
