FactoryBot.define do
  factory :item do
    type { Faker::Lorem.word }
    area { Faker::Lorem.word }
  end
end