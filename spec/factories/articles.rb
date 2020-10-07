FactoryBot.define do
  factory :article do
    title { '筋トレメニュー' }
    target_site { 'ターゲット部位' }
    content { 'メニューの内容' }
    important_point { '注意点など' }
    association :user
  end
end
