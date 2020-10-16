class AddDismissedToVacancyApplications < ActiveRecord::Migration[5.1]
  def change
    add_column :vacancy_applications, :dismissed, :boolean, default: false
  end
end
