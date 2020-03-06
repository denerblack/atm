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
end
