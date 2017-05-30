class AddOtherAspirationToClients < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :other_aspiration, :string
  end
end
