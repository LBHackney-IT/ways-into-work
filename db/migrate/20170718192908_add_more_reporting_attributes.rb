class AddMoreReportingAttributes < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :health_conditions, :boolean, default: nil
    add_column :clients, :affected_by_welfare, :boolean, default: nil
    add_column :clients, :funded, :boolean, default: nil
  end
end
