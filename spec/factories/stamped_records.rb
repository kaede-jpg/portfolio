FactoryBot.define do
  factory :stamped_record do
    association :record, factory: :record
    association :stamp, factory: :stamp
  end
end
