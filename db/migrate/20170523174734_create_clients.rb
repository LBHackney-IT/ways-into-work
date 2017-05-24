class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string :title
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :address_line_1
      t.string :address_line_2
      t.string :address_line_3
      t.string :postcode
      t.datetime :date_of_birth
      t.string :employment_status
      t.string :benefits_status

      t.timestamps null: false
    end
  end
end
