FactoryBot.define do
  factory :training_menu do
    menu { 'ベンチプレス' }
    weight { '100' }
    rep { '10' }
    set { '3' }
    association :record
  end
end
