require_relative '../rails_helper'

RSpec.describe Transaction, type: :model do
  it 'makes a deposit' do
    account_to = FactoryBot.create(:account, :one)
    Transaction.make_deposit('00001', 100.00)
    expect(account_to.reload.balance).to eq BigDecimal(5100)
    expect(account_to.reload.transactions.size).to eq 1
  end

  context "Withdraws" do
    let!(:account_from) { FactoryBot.create(:account, :one) }

    it 'makes a withdraw' do
      Transaction.make_withdraw('00001', 1_000.00)
      expect(account_from.reload.balance).to eq BigDecimal(4000)
      expect(account_from.reload.transactions.size).to eq 1
    end

    it 'makes a withdraw with error' do
      expect { Transaction.make_withdraw('00001', 6_200.00) }.to raise_error
    end
  end

  context "Makes transfers" do
    let!(:account_from) { FactoryBot.create(:account, :one) }
    let!(:account_to) { FactoryBot.create(:account, :two) }

    context 'transfer mon to fri bt 9 and 18 hours' do
      it 'less than 1000' do
        transactioned_at = DateTime.parse('Thu, 05 Mar 2020 12:19:19 +0000')
        Transaction.make_transfer('00001', '00002', 500.0, transactioned_at)
        expect(account_from.reload.balance).to eq BigDecimal(4495)
        expect(account_to.reload.balance).to eq BigDecimal(500)
      end

      it 'greather than 1000' do
        transactioned_at = DateTime.parse('Thu, 05 Mar 2020 12:19:19 +0000')
        Transaction.make_transfer('00001', '00002', 1100.0, transactioned_at)
        expect(account_from.reload.balance).to eq BigDecimal(3885)
        expect(account_to.reload.balance).to eq BigDecimal(1100)
      end
    end

    context 'transfer another times' do
      context 'Day out of Mon and Fri' do
        let!(:transactioned_at) { DateTime.parse('Sun, 01 Mar 2020 12:19:19 +0000') }
        it 'less than 1000' do
          Transaction.make_transfer('00001', '00002', 500.0, transactioned_at)
          expect(account_from.reload.balance).to eq BigDecimal(4493)
          expect(account_to.reload.balance).to eq BigDecimal(500)
        end

        it 'greather than 1000' do
          Transaction.make_transfer('00001', '00002', 1100.0, transactioned_at)
          expect(account_from.reload.balance).to eq BigDecimal(3883)
          expect(account_to.reload.balance).to eq BigDecimal(1100)
        end
      end

      context "Our of" do
        let!(:transactioned_at) { DateTime.parse('Thu, 05 Mar 2020 18:19:19 +0000') }
        it 'less than 1000' do
          Transaction.make_transfer('00001', '00002', 500.0, transactioned_at)
          expect(account_from.reload.balance).to eq BigDecimal(4493)
          expect(account_to.reload.balance).to eq BigDecimal(500)
        end

        it 'greather than 1000' do
          Transaction.make_transfer('00001', '00002', 1100.0, transactioned_at)
          expect(account_from.reload.balance).to eq BigDecimal(3883)
          expect(account_to.reload.balance).to eq BigDecimal(1100)
        end
      end
    end
  end
end
