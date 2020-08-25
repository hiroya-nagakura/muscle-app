FactoryBot.define do
  factory :article do
    title { '筋トレメニュー' }
    target_site { 'ターゲット部位' }
    need { '必要な器具' }
    recommended_target { 'おすすめしたい人' }
    important_point { '注意点など' }
    user
    created_at { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
  end
end
