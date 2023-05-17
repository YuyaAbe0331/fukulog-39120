FactoryBot.define do
  factory :garment do
    name {Faker::Lorem.sentence}
    genre_id { Faker::Number.between(from: 2, to: 5) }
    category_id { Faker::Number.between(from: 2, to: 26) }
    brand {Faker::Lorem.sentence}
    material { Faker::Lorem.paragraph }
    size { Faker::Lorem.paragraph }
    other { Faker::Lorem.paragraph }
    association :user

    after(:build) do |garment|
      garment.image.attach(io: File.open('public/images/test_image1.jpeg'), filename: 'test_image1.jpeg')
    end
  end
end
