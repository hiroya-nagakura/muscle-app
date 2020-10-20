FactoryBot.define do
  factory :tag do
    name  { 'タグ' }
    association :tag_group
  end
end
