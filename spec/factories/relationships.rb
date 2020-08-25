FactoryBot.define do
  factory :relationship do
    association :user
    association :follow
  end
end
