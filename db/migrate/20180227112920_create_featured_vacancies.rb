class CreateFeaturedVacancies < ActiveRecord::Migration[5.1]
  def change
    create_table :featured_vacancies do |t|
      t.integer :position, unique: true
      t.references :vacancy
    end
  end
end
