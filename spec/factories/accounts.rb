FactoryBot.define do
  factory :account do
    user

    trait :one do
      id { 1 }
      number { "00001" }
      balance { 5_000 }
    end

    trait :two do
      id { 2 }
      number { "00002" }
      balance { 0.0 }
    end
  end
end
