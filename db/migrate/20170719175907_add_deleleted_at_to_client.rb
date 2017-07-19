class AddDeleletedAtToClient < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :deleted_at, :datetime, index: true
  end
end
