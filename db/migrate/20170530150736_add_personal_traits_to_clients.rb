class AddPersonalTraitsToClients < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :personal_traits, :string, array: true, default: []
    add_column :clients, :other_personal_trait, :string
  end
end
