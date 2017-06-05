class AddEducationAsBoolean < ActiveRecord::Migration[5.1]
  def change
    remove_column :clients, :studying, :boolean
    add_column :clients, :studying, :boolean, default: nil
    add_column :clients, :studying_part_time, :boolean, default: nil
  end
end
