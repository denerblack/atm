require_relative '../rails_helper'

RSpec.describe TransactionsService do
  #let!(:account_from) { FactoryBot.create(:account, :one) }
  #let!(:account_to) { FactoryBot.create(:account, :two) }

  context "Deposits" do
    let!(:account_to) { FactoryBot.create(:account, :one) }
    let!(:transactions_service) { TransactionsService.new(Time.now) }

    it 'makes a deposit' do
      result = transactions_service.make_deposit(account_to.number, 100.00)
      expect(result.success?).to eq(true)
      expect(account_to.reload.balance).to eq BigDecimal(5_100)
      expect(account_to.reload.transactions.size).to eq 1
    end

    it 'error negative deposit' do
      result = transactions_service.make_deposit(account_to.number, -100.00)
      expect(result.success?).to eq(false)
    end
  end

  context "Withdraws" do
    let!(:account_from) { FactoryBot.create(:account, :one) }
    let!(:transactions_service) { TransactionsService.new(Time.now) }

    it 'makes a withdraw' do
      transactions_service.make_withdraw(account_from.number, 1_000.00)
      expect(account_from.reload.balance).to eq BigDecimal(4000)
      expect(account_from.reload.transactions.size).to eq 1
    end

    it 'makes a withdraw with error' do
      result = transactions_service.make_withdraw(account_from.number, 100_200.00)
      expect(result.success?).to eq(false)
    end
  end

  context "Makes transfers" do
    let!(:account_from) { FactoryBot.create(:account, :one) }
    let!(:account_to) { FactoryBot.create(:account, :two) }

    context 'transfer mon to fri bt 9 and 18 hours' do
      it 'less than 1000' do
        transactioned_at = DateTime.parse('Thu, 05 Mar 2020 12:19:19 +0000')
        transactions_service = TransactionsService.new(transactioned_at)
        transactions_service.make_transfer(account_from.number, account_to.number, 500.0)
        expect(account_from.reload.balance).to eq BigDecimal(4495)
        expect(account_to.reload.balance).to eq BigDecimal(500)
      end

      it 'greather than 1000' do
        transactioned_at = DateTime.parse('Thu, 05 Mar 2020 12:19:19 +0000')
        transactions_service = TransactionsService.new(transactioned_at)
        transactions_service.make_transfer(account_from.number, account_to.number, 1100.0)
        expect(account_from.reload.balance).to eq BigDecimal(3885)
        expect(account_to.reload.balance).to eq BigDecimal(1100)
      end
    end

    context 'account to not found' do
      let!(:transactions_service) { TransactionsService.new(Time.now) }

      it 'returns success false' do
        result = transactions_service.make_transfer(account_from.number, '332s3', 1100.0)
        expect(result.success?).to eq(false)
      end
    end


    context 'transfer another times' do
      context 'Day out of Mon and Fri' do
        let!(:transactions_service) { TransactionsService.new(DateTime.parse('Sun, 01 Mar 2020 12:19:19 +0000')) }
        it 'less than 1000' do
          transactions_service.make_transfer(account_from.number, account_to.number, 500.0)
          expect(account_from.reload.balance).to eq BigDecimal(4493)
          expect(account_to.reload.balance).to eq BigDecimal(500)
        end

        it 'greather than 1000' do
          transactions_service.make_transfer(account_from.number, account_to.number, 1100.0)
          expect(account_from.reload.balance).to eq BigDecimal(3883)
          expect(account_to.reload.balance).to eq BigDecimal(1100)
        end
      end

      context "Our of" do
        let!(:transactions_service) { TransactionsService.new(DateTime.parse('Thu, 05 Mar 2020 18:19:19 +0000')) }
        it 'less than 1000' do
          transactions_service.make_transfer(account_from.number, account_to.number, 500.0)
          expect(account_from.reload.balance).to eq BigDecimal(4493)
          expect(account_to.reload.balance).to eq BigDecimal(500)
        end

        it 'greather than 1000' do
          transactions_service.make_transfer(account_from.number, account_to.number, 1100.0)
          expect(account_from.reload.balance).to eq BigDecimal(3883)
          expect(account_to.reload.balance).to eq BigDecimal(1100)
        end
      end
    end
  end
end
