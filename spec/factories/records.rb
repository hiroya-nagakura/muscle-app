FactoryBot.define do
  factory :record do
    main_target { '大胸筋' }
    start_time { '2020-09-26 00:00:00' }
    association :user
  end
end
