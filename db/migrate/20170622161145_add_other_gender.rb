class AddOtherGender < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :other_gender, :string, default: nil
    remove_column :clients, :affected_by_welfare_reform, :boolean
  end
end
