FactoryBot.define do
  factory :user do
    sequence(:user_id, &:to_s)
    name { 'name' }
    sequence(:email) { |n| "runteq_#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
