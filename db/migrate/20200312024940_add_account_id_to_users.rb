class AddAccountIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :account, null: true, foreign_key: true
  end
end
