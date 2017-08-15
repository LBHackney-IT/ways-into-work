class DropServiceManagers < ActiveRecord::Migration[5.1]
  def up
    drop_table :service_managers
  end

  def down
    create_table :service_managers do |t|
      t.string :name
    end
  end
end
