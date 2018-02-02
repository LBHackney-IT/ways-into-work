class RemoveQualificationsFromClients < ActiveRecord::Migration[5.1]
  def change
    remove_column :clients, :qualifications, :string, array: true, default: []
  end
end
