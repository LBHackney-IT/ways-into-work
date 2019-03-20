class AddDefaultStatusToEnquiries < ActiveRecord::Migration[5.1]
  def change
    change_column :enquiries, :status, :integer, default: 0
  end
end
