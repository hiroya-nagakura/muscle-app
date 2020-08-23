FactoryBot.define do
  factory :user do
    user_name { 'TestUser' }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { 'password' }
  end
end
