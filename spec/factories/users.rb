FactoryBot.define do
  factory :user do
    email {Faker::Internet.free_email}
    password {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    nickname {Faker::Name.last_name}
    sex_id { Faker::Number.between(from: 2, to: 5) }
    height_id { Faker::Number.between(from: 1, to: 16) }
    weight_id { Faker::Number.between(from: 1, to: 15) }
  end
end