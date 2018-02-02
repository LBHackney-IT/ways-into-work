class EvenMoreClientFields < ActiveRecord::Migration[5.1]
  def change
    remove_column :clients, :affected_by_welfare, :boolean
    add_column :clients, :welfare_calculation_completed, :boolean
  end
end
