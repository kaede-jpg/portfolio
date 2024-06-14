FactoryBot.define do
  factory :user do
    sequence(:user_id, &:to_s)
    name { 'name' }
    sequence(:email) { |n| "email_#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }

    trait :monitor do
      role { 'monitor' }
    end

    trait :monitored do
      role { 'monitored' }
    end
  end
end
