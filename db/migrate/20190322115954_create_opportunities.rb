class CreateOpportunities < ActiveRecord::Migration[5.1]
  def change
    create_table :opportunities do |t|
      t.string :title
      t.string :short_description
      t.string :location
      t.datetime :closing_date
      t.string :actable_type
      t.integer :actable_id
      t.timestamps
    end
  end
end
