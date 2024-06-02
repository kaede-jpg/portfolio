FactoryBot.define do
  factory :comment do
    user { nil }
    record { nil }
    body { 'MyText' }
  end
end
