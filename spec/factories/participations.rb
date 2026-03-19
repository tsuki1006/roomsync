FactoryBot.define do
  factory :participation do
    association :user
    association :schedule
  end
end
