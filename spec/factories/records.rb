FactoryBot.define do
  factory :record do
    association :user, factory: :user

    after(:build) do |record|
      record.meal_image.attach(io: File.open('spec/fixtures/test_image.png'), filename: 'test_image.png', content_type: 'image/png')
    end
  end
end
