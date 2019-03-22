class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.string :pay
      t.string :contract
      t.string :sector
      t.text :full_description
    end
  end
end
