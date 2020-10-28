class CreateApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :applications do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :email
      t.string :type
      t.text :statement
      t.integer :wordpress_object_id
      t.boolean :dismissed, default: false
      t.timestamps null: false
    end
  end
end
