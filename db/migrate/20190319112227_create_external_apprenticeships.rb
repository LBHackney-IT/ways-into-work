class CreateExternalApprenticeships < ActiveRecord::Migration[5.1]
  def change
    create_table :external_apprenticeships do |t|
      t.string :qualification
      t.string :pay
      t.string :contract
      t.string :sector
      t.text :full_description
    end
  end
end
