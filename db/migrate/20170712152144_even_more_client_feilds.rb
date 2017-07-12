class EvenMoreClientFeilds < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :bame, :string
    add_column :clients, :other_bame, :string
    rename_column :clients, :lone_parent, :single_parent
  end
end
