class CreateReferrer < ActiveRecord::Migration[5.1]
  def change
    create_table :referrers do |t|
      t.string :name
      t.string :organisation
      t.string :phone
      t.string :email
      t.text :reason
    end
  end
end
