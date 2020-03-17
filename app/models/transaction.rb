class Transaction < ApplicationRecord
  extend Enumerize

  scope :list_of, -> (account) { where("account_from_id = ? OR account_to_id = ?", account.id, account.id).order(created_at: :desc) }

  belongs_to :account_to, foreign_key: :account_to_id, class_name: "Account", required: false
  belongs_to :account_from, foreign_key: :account_from_id, class_name: "Account", required: false

  enumerize :kind, in: [:deposit, :withdraw, :transfer, :rate]

end
