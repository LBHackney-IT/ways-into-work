class CreateWorkPlacements < ActiveRecord::Migration[5.1]
  def change
    create_table :work_placements do |t|
      t.string :pay
      t.string :contract
      t.string :sector
      t.text :full_description
    end
  end
end
