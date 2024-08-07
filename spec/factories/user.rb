FactoryBot.define do
  factory :user do
    name { 'name' }
    sequence(:email) { |n| "email_#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    agreement { true }

    trait :monitor do
      role { 'monitor' }
    end

    trait :monitored do
      role { 'monitored' }
    end
  end
end
