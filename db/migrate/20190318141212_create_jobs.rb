class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :short_description
      t.datetime :end_date
      t.string :salary
      t.text :long_description
      t.string :reference_number
      t.string :location
      t.timestamps
    end
  end
end
