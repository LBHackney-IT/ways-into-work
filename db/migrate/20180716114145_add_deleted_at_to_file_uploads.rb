class AddDeletedAtToFileUploads < ActiveRecord::Migration[5.1]
  def change
    add_column :file_uploads, :deleted_at, :datetime
    add_index :file_uploads, :deleted_at
  end
end
