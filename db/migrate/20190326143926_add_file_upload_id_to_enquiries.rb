class AddFileUploadIdToEnquiries < ActiveRecord::Migration[5.1]
  def change
    add_column :enquiries, :file_upload_id, :integer
  end
end
