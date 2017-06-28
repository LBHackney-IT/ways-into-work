class AddWardMapitCodesToHub < ActiveRecord::Migration[5.1]
  def change
    add_column :hubs, :ward_mapit_codes, :string, array: true, default: []
  end
end
