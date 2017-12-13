class ChangeFundedToArray < ActiveRecord::Migration[5.1]
  def change
    ids = Client.where(funded: true).pluck(:id)
    remove_column :clients, :funded, :boolean
    add_column :clients, :funded, :string, default: [], array: true
    Client.where(id: ids).each { |c| c.funded = ['flexible_support_fund'] && c.save }
  end
end
