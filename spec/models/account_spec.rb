require 'rails_helper'

RSpec.describe Account, type: :model do
  let!(:account) { FactoryBot.create(:account, :one) }

  it 'credits' do
    account.credit(500)
    expect(account.reload.balance).to eq(BigDecimal(5500))
  end

  it 'debits' do
    account.debit(500)
    expect(account.reload.balance).to eq(BigDecimal(4500))
  end

  it 'create number' do
    new_account = FactoryBot.create(:account, id: 4)
    expect(new_account.reload.number).to eq("00004")
  end
end
