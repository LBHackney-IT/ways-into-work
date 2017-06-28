class CreateMeetings < ActiveRecord::Migration[5.1]
  def change
    create_table :meetings do |t|
      t.datetime :start_datetime
      t.text :notes
      t.string :agenda
      t.string :other_agenda
      t.belongs_to :advisor
      t.belongs_to :client, null: false
      t.timestamps
    end
  end
end
