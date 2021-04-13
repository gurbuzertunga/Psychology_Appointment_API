FactoryBot.define do
  factory :appointment do
    problem { Faker::Lorem.word }
    date { Faker::Date.between(from: '2021-01-01', to: '2021-04-13') }
    time { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    consultancies_id nil
  end
end