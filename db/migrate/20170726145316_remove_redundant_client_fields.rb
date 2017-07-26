class RemoveRedundantClientFields < ActiveRecord::Migration[5.1]
  def change
    remove_column :clients, :has_children, :boolean, default: nil
    remove_column :clients, :single_parent, :boolean, default: nil
    remove_column :clients, :below_living_wage, :boolean, default: nil
  end
end
