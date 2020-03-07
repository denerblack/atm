class AddTransactionedAtToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :transactioned_at, :datetime
  end
end
