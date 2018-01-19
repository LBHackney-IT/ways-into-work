class RemoveOptionsFromAdvisor < ActiveRecord::Migration[5.1]
  def change
    remove_column :advisors, :options, :json, default: {}
  end
end
