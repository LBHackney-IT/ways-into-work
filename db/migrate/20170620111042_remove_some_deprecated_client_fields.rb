class RemoveSomeDeprecatedClientFields < ActiveRecord::Migration[5.1]
  def change
    remove_column :clients, :address_line_3, :string
    remove_column :clients, :title, :string

    remove_column :user_logins, :confirmation_token, :string
    remove_column :user_logins, :confirmed_at, :datetime
    remove_column :user_logins, :confirmation_sent_at, :datetime
  end
end
