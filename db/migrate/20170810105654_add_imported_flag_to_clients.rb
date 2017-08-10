class AddImportedFlagToClients < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :imported, :boolean, default: false
  end
end
