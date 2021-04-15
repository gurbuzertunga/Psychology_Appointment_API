FactoryBot.define do
  factory :appointment do
    problem { Faker::Lorem.word }
    time { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    consultancy_id 2
  end
end