FactoryBot.define do
  factory :article do
    title { '筋トレメニュー' }
    content { 'メニューの内容' }
    important_point { '注意点など' }
    association :user
    association :target_site
  end
end
