class AddConsentGivenCheckbox < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :consent_given, :boolean
  end
end
