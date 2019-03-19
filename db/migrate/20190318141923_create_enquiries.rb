class CreateEnquiries < ActiveRecord::Migration[5.1]
  def change
    create_table :enquiries do |t|
      t.integer :client_id
      t.integer :opportunity_id
      t.string :opportunity_type
      t.integer :status
      t.timestamps
    end
  end
end
