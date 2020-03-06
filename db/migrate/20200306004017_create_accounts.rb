class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :number
      t.decimal :balance, precision: 10, scale: 2, default: 0.0
      t.string :password

      t.timestamps
    end
  end
end
