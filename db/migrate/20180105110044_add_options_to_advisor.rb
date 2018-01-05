class AddOptionsToAdvisor < ActiveRecord::Migration[5.1]
  def change
    add_column :advisors, :options, :json, default: {}
  end
end
