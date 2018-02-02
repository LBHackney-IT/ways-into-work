class AddHealthBariersToClients < ActiveRecord::Migration[5.1]
  def up
    add_column :clients, :health_barriers, :string, array: true, default: []

    # For consistency
    rename_column :clients, :health_conditions, :health_condition

    # Realised that prefer not to say was not being persisted.
    change_column :clients, :health_condition, :string, default: nil
    change_column :clients, :care_leaver, :string, default: nil

    convert_boolean_to_string
  end

  def down
    convert_string_to_boolean

    change_column :clients, :health_condition, 'boolean USING CAST(health_condition AS boolean)'
    change_column :clients, :care_leaver, 'boolean USING CAST(care_leaver AS boolean)'
    rename_column :clients, :health_condition, :health_conditions

    remove_column :clients, :health_barriers, :string, array: true, default: []
  end

  def convert_boolean_to_string
    Client.where(health_condition: 'true').each do |cl|
      cl.health_condition = 'Yes'
      cl.save(validate: false)
    end
    Client.where(health_condition: 'false').each do |cl|
      cl.health_condition = 'No'
      cl.save(validate: false)
    end
    Client.where(care_leaver: 'true').each do |cl|
      cl.care_leaver = 'Yes'
      cl.save(validate: false)
    end
    Client.where(care_leaver: 'false').each do |cl|
      cl.care_leaver = 'No'
      cl.save(validate: false)
    end
  end

  def convert_string_to_boolean
    Client.where(health_condition: 'Yes').each do |cl|
      cl.health_condition = 'true'
      cl.save(validate: false)
    end
    Client.where(health_condition: 'No').each do |cl|
      cl.health_condition = 'false'
      cl.save(validate: false)
    end
    Client.where(care_leaver: 'Yes').each do |cl|
      cl.care_leaver = 'true'
      cl.save(validate: false)
    end
    Client.where(care_leaver: 'No').each do |cl|
      cl.care_leaver = 'false'
      cl.save(validate: false)
    end
  end
end
