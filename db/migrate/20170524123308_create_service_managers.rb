class CreateServiceManagers < ActiveRecord::Migration[5.1]
  def change
    create_table :service_managers do |t|
      t.string :name
    end
  end
end
