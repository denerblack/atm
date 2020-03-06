class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.integer :account_from_id
      t.integer :account_to_id
      t.string :kind
      t.decimal :value, precision: 10, scale: 2

      t.timestamps
    end
  end
end
