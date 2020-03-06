class Account < ApplicationRecord

  before_save :check_balance

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
end
