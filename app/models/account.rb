class Account < ApplicationRecord

  ACCOUNT_LENGTH = 5

  has_one :user

  validate :check_balance
  after_create :build_number

  def transactions
    Transaction.list_of(self)
  end

  def credit(value)
    update(balance: balance + value)
  end

  def debit(value)
    update(balance: balance - value)
  end

  private

  def check_balance
    errors.add(:balance, "Saldo insuficiente para esta operação.") if balance < 0
  end

  def build_number
    preffix = (ACCOUNT_LENGTH - id.to_s.size).times.inject(String.new) { |str, i| str << "0"; }
    update(number: preffix << id.to_s)
  end
end
