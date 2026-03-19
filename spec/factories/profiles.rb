FactoryBot.define do
  factory :profile do
    name { Faker::Lorem.characters(number: 10) }
    course { Profile.courses.keys.sample }

    association :user
  end
end
