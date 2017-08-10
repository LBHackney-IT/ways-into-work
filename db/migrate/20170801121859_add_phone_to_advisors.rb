class AddPhoneToAdvisors < ActiveRecord::Migration[5.1]
  def change
    add_column :advisors, :phone, :string
  end
end
