FactoryBot.define do
  factory :schedule do
    base_time = Time.current.change(min: 0)

    start_time { base_time + 1.hour }
    end_time   { base_time + 3.hour }

    association :creator, factory: :user
    association :room
  end
end
