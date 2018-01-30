class RemoveUnnecassaryFields < ActiveRecord::Migration[5.1]
  def change
    remove_column :clients, :affected_by_welfare, :boolean
    remove_column :clients, :qualifications, :string, array: true, default: []

  end
end
