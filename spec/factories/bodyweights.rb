FactoryBot.define do
  factory :bodyweight do
    weight { 70.0 }
    day { '2020-09-26' }
    association :user
  end
end
