class MoreClientFields < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :support_priorities, :string, array: true, default: []
    add_column :clients, :other_support_priority, :string
    rename_column :clients, :type_of_works, :types_of_work
  end
end
