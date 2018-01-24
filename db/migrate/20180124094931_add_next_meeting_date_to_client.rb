class AddNextMeetingDateToClient < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :next_meeting_date, :datetime
  end
end
