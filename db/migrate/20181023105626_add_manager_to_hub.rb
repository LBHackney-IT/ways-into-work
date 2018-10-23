class AddManagerToHub < ActiveRecord::Migration[5.1]
  def change
    change_table :hubs do |t|
      t.references :manager, references: :advisors
    end
  end
end
