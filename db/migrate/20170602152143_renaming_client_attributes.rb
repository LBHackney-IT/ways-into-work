class RenamingClientAttributes < ActiveRecord::Migration[5.1]
  def change
    remove_column :clients, :employment_status, :string, array: true
    add_column :clients, :employed, :boolean, default: nil
    add_column :clients, :studying, :boolean, default: nil
    add_column :clients, :working_hours_per_week, :integer, default: nil
    add_column :clients, :time_since_last_job, :string, default: nil
    add_column :clients, :job_title, :string, default: nil
    add_column :clients, :current_education, :string, default: nil
    add_column :clients, :past_education, :string, default: nil
  end
end
