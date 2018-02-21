class AddWelfareCalculationNotes < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :welfare_calculation_notes, :string
  end
end
