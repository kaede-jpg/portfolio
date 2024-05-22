FactoryBot.define do
  factory :relationship do
    association :monitor, factory: :user
    association :monitored, factory: :user
  end
end
