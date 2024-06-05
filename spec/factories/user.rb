FactoryBot.define do
  factory :user do
    sequence(:user_id, &:to_s)
    name { 'name' }
    sequence(:email) { |n| "email_#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }

    trait :monitor do
      invitation_my_role { "monitor" }
    end

    trait :monitored do
      invitation_my_role { "monitored" }
    end

  end
end
