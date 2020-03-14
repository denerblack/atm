class UserDecorator < SimpleDelegator

  def fullname
    "#{first_name} #{last_name}"
  end

  def transactions
    account.transactions.map { |t| TransactionDecorator.new(t) }
  end
end
