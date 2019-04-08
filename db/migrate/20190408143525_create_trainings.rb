class CreateTrainings < ActiveRecord::Migration[5.1]
  def change
    create_table :trainings do |t|
      t.string :url
      t.string :qualification
    end
  end
end
