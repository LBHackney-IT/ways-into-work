class CreateContactNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :contact_notes do |t|
      t.text :content
      t.string :contact_method
      t.belongs_to :advisor, index: true
      t.belongs_to :client, index: true
      t.timestamps
    end
    add_column :clients, :contact_notes_count, :integer, default: 0
  end
end
