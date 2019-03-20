class AddSupportingStatementToEnquiries < ActiveRecord::Migration[5.1]
  def change
    add_column :enquiries, :supporting_statement, :text
  end
end
