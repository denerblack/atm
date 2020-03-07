require_relative '../rails_helper'

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
end
