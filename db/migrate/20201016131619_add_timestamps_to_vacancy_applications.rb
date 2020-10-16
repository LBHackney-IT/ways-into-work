class AddTimestampsToVacancyApplications < ActiveRecord::Migration[5.1]
  def change
    add_column :vacancy_applications, :created_at, :datetime, null: false
    add_column :vacancy_applications, :updated_at, :datetime, null: false
  end
end
