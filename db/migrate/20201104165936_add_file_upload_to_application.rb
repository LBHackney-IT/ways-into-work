class AddFileUploadToApplication < ActiveRecord::Migration[5.1]
  def change
    add_column :applications, :file_upload_id, :integer
  end
end
