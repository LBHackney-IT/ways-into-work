class AddWantsAdvisorToClients < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :wants_advisor, :boolean, default: true
  end
end
