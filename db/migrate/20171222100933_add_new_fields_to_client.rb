class AddNewFieldsToClient < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :national_insurance_number, :string
    add_column :clients, :affected_by_benefit_cap, :boolean
    add_column :clients, :assigned_supported_employment, :boolean
  end
end
