FactoryBot.define do
  factory :room do
    name { Faker::Lorem.characters(number: 10) }
    room_key { Faker::Lorem.characters(number: 10) }

    association :creator, factory: :user
  end
end
