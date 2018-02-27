class CreateVacancies < ActiveRecord::Migration[5.1]
  def change
    create_table :vacancies do |t|
      t.string :title
      t.integer :vacancy_type
      t.string :salary
      t.text :description
    end
  end
end
