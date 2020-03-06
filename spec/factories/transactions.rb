FactoryBot.define do
  factory :transaction do
    account_from_id { 1 }
    account_to_id { 1 }
    kind { "MyString" }
    value { "9.99" }
  end
end
