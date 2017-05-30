class RenameBenefitsStatus < ActiveRecord::Migration[5.1]
  def change
    remove_column :clients, :employment_status, :string
    remove_column :clients, :benefits_status, :string
    add_column :clients, :aspirations, :string, array: true, default: []
    add_column :clients, :employment_status, :string, array: true, default: []
  end
end
