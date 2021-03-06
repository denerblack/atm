class TransactionsService
  attr_accessor :transactioned_at

  def initialize(transactioned_at = Time.now)
    @transactioned_at = transactioned_at
  end

  def make_deposit(account_number, value)
    Transaction.transaction do
      begin
        raise ArgumentError.new("Não é permitido depositar um valor negativo") if value < 0.0
        account = Account.find_by(number: account_number)
        Transaction.create(kind: :deposit, account_to: account, value: value, transactioned_at: transactioned_at)
        account.credit(value)
        OpenStruct.new(success?: true, message: "Depositado #{value} na sua conta.")
      rescue => e
        OpenStruct.new(success?: false, message: e)
      end
    end
  end

  def make_withdraw(account_number, value)
    Transaction.transaction do
      begin
        account = Account.find_by(number: account_number)
        Transaction.create(kind: :withdraw, account_from: account, value: value, transactioned_at: transactioned_at)
        account.debit(value)
        raise ArgumentError.new(account.errors.full_messages.join("\n")) unless account.valid?
        OpenStruct.new(success?: true, message: "Efetuado o saque de #{value} da sua conta.")
      rescue => e
        OpenStruct.new(success?: false, message: e)
      end
    end
  end

  def make_transfer(account_from_number, account_to_number, value)
    Transaction.transaction do
      begin
        account_from = Account.find_by(number: account_from_number)
        account_to = Account.find_by!(number: account_to_number)
        transfer_rate = transfer_rate(transactioned_at, value)

        Transaction.create(kind: :transfer, account_from: account_from, account_to: account_to, value: value, transactioned_at: transactioned_at)
        Transaction.create(kind: :rate, account_from: account_from, value: transfer_rate, transactioned_at: transactioned_at)
        account_from.debit(value)
        account_from.debit(transfer_rate)
        account_to.credit(value)
        OpenStruct.new(success?: true, message: "Transferido #{value} para #{account_to.user.fullname}.")
      rescue ActiveRecord::RecordNotFound => e
        OpenStruct.new(success?: false, message: e.to_s)
      end
    end
  end

  private

  def transfer_rate(transactioned_at, value)
    time = transactioned_at.strftime("%H:%M")
    wday = transactioned_at.wday

    rate = if ("09:00".."18:00").to_a.include?(time) && wday >= 1 && wday <=5
             BigDecimal(5)
           else
             BigDecimal(7)
           end

    rate += BigDecimal(10) if value > 1000
    rate
  end

end
