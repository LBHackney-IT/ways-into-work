class CreateEnquiries < ActiveRecord::Migration[5.1]
  def change
    create_table :enquiries do |t|
      t.integer :client_id
      t.integer :opportunity_id
      t.text :supporting_statement
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
