FactoryBot.define do
  factory :article_tag do
    association :article
    association :tag
  end
end
