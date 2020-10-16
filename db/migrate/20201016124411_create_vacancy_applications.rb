class CreateVacancyApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :vacancy_applications do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :email
      t.text :statement
      t.integer :vacancy_id
    end
  end
end
