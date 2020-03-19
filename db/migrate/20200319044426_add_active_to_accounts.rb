class AddActiveToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :active, :boolean, default: 1
  end
end
