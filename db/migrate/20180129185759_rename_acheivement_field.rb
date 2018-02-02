class RenameAcheivementField < ActiveRecord::Migration[5.1]
  def change
    rename_column :achievements, :date_acheived, :date_achieved
  end
end
