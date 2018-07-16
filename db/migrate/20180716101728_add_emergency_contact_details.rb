class AddEmergencyContactDetails < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :emergency_contact_name, :string
    add_column :clients, :emergency_contact_phone, :string
  end
end
