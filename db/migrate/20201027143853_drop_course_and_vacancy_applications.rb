class DropCourseAndVacancyApplications < ActiveRecord::Migration[5.1]
  def change
    drop_table :course_applications do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :email
      t.integer :intake_id
      t.boolean :dismissed, default: false
      t.timestamps null: false
    end
    drop_table :vacancy_applications do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :email
      t.integer :vacancy_id
      t.text :statement
      t.boolean :dismissed, default: false
      t.timestamps null: false
    end
  end
end
