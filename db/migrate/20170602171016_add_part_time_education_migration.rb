class AddPartTimeEducationMigration < ActiveRecord::Migration[5.1]
  def change
    remove_column :clients, :studying, :boolean
    add_column :clients, :studying, :integer, default: 0, null: false
  end
end
