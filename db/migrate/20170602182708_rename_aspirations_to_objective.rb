class RenameAspirationsToObjective < ActiveRecord::Migration[5.1]
  def change
    rename_column :clients, :aspirations, :objectives
    rename_column :clients, :other_aspiration, :other_objective
  end
end
