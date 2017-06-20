class CreatingHubs < ActiveRecord::Migration[5.1]
  def change
    create_table :hubs do |t|
      t.string :name
      t.string :address_line_1
      t.string :address_line_2
      t.string :postcode
      t.float :longitude
      t.float :latitude
    end

    add_reference :service_managers, :hub, index: true, foreign_key: true
    add_reference :advisors, :hub, index: true, foreign_key: true
    add_reference :clients, :advisor, index: true, foreign_key: true
  end
end
