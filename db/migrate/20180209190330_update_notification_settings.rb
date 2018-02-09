class UpdateNotificationSettings < ActiveRecord::Migration[5.1]
  def up
    Client.where('preferred_contact_method is not null').each do |cl|
      cl.preferred_contact_method = cl.preferred_contact_method.split.first.downcase
      cl.save(validate: false)
    end
    rename_column :clients, :preferred_contact_method, :preferred_contact_methods
    change_column :clients, :preferred_contact_methods, "varchar[] USING (string_to_array(preferred_contact_methods, ','))", default: []
  end

  def down
    change_column :clients, :preferred_contact_methods, :string
    rename_column :clients, :preferred_contact_methods, :preferred_contact_method
  end
end
