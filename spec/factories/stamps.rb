FactoryBot.define do
  factory :stamp do
    after(:build) do |record|
      record.stamp_image.attach(io: File.open('spec/fixtures/test_image.png'), filename: 'test_image.png', content_type: 'image/png')
    end
  end
end
