class AddReferrerIdToClient < ActiveRecord::Migration[5.1]
  def change
    add_reference :clients, :referrer, index: true, foreign_key: true
  end
end
