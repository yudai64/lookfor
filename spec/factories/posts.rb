FactoryBot.define do
  factory :post do
    title { "テスト投稿" }
    description { "これはテスト詳細です" }
    user
  end
end
