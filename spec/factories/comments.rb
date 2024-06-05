FactoryBot.define do
  factory :comment do
    association :user, factory: :user
    association :record, factory: :record
    body { 'MyText' }
  end
end
