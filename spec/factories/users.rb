FactoryBot.define do
  factory :user, aliases: [:follow] do
    user_name { 'TestUser' }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
