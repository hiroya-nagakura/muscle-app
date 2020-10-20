FactoryBot.define do
  factory :record do
    main_target { '大胸筋' }
    start_time { '2020-09-26 00:00:00' }
    association :user
    after(:build) do |record|
      record.training_menus << build(:training_menu, record: record)  
    end
  end
end
