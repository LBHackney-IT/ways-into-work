class DeviseCreateUserLogins < ActiveRecord::Migration[5.1]
  def change
    create_table :user_logins do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      t.belongs_to :user, polymorphic: true
    end

    add_index :user_logins, :email,                unique: true
    add_index :user_logins, :reset_password_token, unique: true
  end
end
