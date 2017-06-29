class AddMeetingsCountToClients < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :meetings_count, :integer, default: 0
  end
end
