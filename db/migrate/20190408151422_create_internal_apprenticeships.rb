class CreateInternalApprenticeships < ActiveRecord::Migration[5.1]
  def change
    create_table :internal_apprenticeships do |t|
      t.string :url
      t.string :contract
      t.string :pay
      t.string :sector
      t.string :qualification
    end
  end
end
