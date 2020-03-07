class Transaction < ApplicationRecord
  extend Enumerize

  scope :list_of, -> (account) { where("account_from_id = ? OR account_to_id = ?", account.id, account.id)}

  belongs_to :account_to, foreign_key: :account_to_id, class_name: "Account", required: false
  belongs_to :account_from, foreign_key: :account_from_id, class_name: "Account", required: false

  enumerize :kind, in: [:deposit, :withdraw, :transfer, :rate]

  def self.make_deposit(account_number, value)
    self.transaction do
      account = Account.find_by(number: account_number)
      self.create(kind: :deposit, account_to: account, value: value)
      account.credit(value)
    end
  end

  def self.make_withdraw(account_number, value)
    self.transaction do
      account = Account.find_by(number: account_number)
      self.create(kind: :withdraw, account_from: account, value: value)
      account.debit(value)
    end
  end

  def self.make_transfer(account_from_number, account_to_number, value, transactioned_at)
    self.transaction do
      account_from = Account.find_by(number: account_from_number)
      account_to = Account.find_by(number: account_to_number)
      transfer_rate = transfer_rate(transactioned_at, value)

      self.create(kind: :transfer, account_from: account_from, account_to: account_to, value: value, transactioned_at: transactioned_at)
      self.create(kind: :rate, account_from: account_from, value: transfer_rate)
      account_from.debit(value)
      account_from.debit(transfer_rate)
      account_to.credit(value)
    end
  end

  private

  def self.transfer_rate(transactioned_at, value)
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
