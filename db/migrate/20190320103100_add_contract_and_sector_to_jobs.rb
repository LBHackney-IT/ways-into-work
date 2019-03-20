class AddContractAndSectorToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :contract, :string
    add_column :jobs, :sector, :string
  end
end
