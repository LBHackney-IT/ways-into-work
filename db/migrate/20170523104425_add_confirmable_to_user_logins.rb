class AddConfirmableToUserLogins < ActiveRecord::Migration[5.1]
  def self.up
    add_column :user_logins, :confirmation_token, :string
    add_column :user_logins, :confirmed_at, :datetime
    add_column :user_logins, :confirmation_sent_at, :datetime
    add_column :user_logins, :unconfirmed_email, :string
    add_index :user_logins, :confirmation_token, unique: true
  end

  def self.down
    remove_columns :user_logins, :confirmation_token, :confirmed_at, :confirmation_sent_at
  end
end
