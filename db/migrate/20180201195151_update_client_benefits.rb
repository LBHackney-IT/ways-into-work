class UpdateClientBenefits < ActiveRecord::Migration[5.1]
  def up
    change_column :clients, :receive_benefits, :string
    add_column :clients, :other_receive_benefits, :string
    Client.where(receive_benefits: 'true').each do |cl|
      cl.receive_benefits = nil
      cl.other_receive_benefits = 'Receiving but unknown..'
      cl.save(validate: false)
    end
    Client.where(receive_benefits: 'false').each do |cl|
      cl.receive_benefits = 'None'
      cl.save(validate: false)
    end
  end

  def down
    remove_column :clients, :other_receive_benefits, :string
    change_column :clients, :receive_benefits, 'boolean USING CAST(receive_benefits AS boolean)'
  end
end
