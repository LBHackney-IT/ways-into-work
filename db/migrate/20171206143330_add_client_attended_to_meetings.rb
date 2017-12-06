class AddClientAttendedToMeetings < ActiveRecord::Migration[5.1]
  def change
    add_column :meetings, :client_attended, :boolean
  end
end
