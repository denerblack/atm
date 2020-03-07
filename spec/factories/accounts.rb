FactoryBot.define do
  factory :account do
    trait :one do
      number { "00001" }
      balance { 5_000 }
    end

    trait :two do
      number { "00002" }
      balance { 0.0 }
    end
  end
end
