require_relative '../rails_helper'

RSpec.describe Transaction, type: :model do
  it 'makes a deposit' do
    account_to = FactoryBot.create(:account, balance: 1_000)
    Transaction.make_deposit('00001', 100.00)
    expect(account_to.reload.balance).to eq 1_100
    expect(account_to.reload.transactions.size).to eq 1
  end

  context "Withdraws" do
    it 'makes a withdraw' do
      account_from = FactoryBot.create(:account, balance: 1_100)
      Transaction.make_withdraw('00001', 1_000.00)
      expect(account_from.reload.balance).to eq 100
      expect(account_from.reload.transactions.size).to eq 1
    end

    it 'makes a withdraw with error' do
      account_from = FactoryBot.create(:account, balance: 1_100)
      expect { Transaction.make_withdraw('00001', 1_200.00) }.to raise_error
    end
  end
end
