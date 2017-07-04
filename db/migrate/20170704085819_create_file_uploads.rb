class CreateFileUploads < ActiveRecord::Migration[5.1]
  def change
    create_table :file_uploads do |t|
      t.string  :attachment_file_name, null: false
      t.integer :attachment_file_size, null: false
      t.string  :attachment_content_type, null: false
      t.string  :uploaded_by, null: false
      t.belongs_to :client, index: true
      t.timestamps
    end
  end
end
