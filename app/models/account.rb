class Account < ApplicationRecord

  ACCOUNT_LENGTH = 5

  before_save :check_balance
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
    raise Exception.new("Conta não pode estar com saldo negativo.") if balance < 0
  end

  def build_number
    preffix = (ACCOUNT_LENGTH - id.to_s.size).times.inject(String.new) { |str, i| str << "0"; }
    update(number: preffix << id.to_s)
  end
end
