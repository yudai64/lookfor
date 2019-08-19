FactoryBot.define do
  factory :post do
    title { "テストです" }
    description { "これはテストです" }
    user
  end
end
