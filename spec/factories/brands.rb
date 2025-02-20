FactoryBot.define do
  factory :brand do
    name { "Brand #{Faker::Lorem.word}" }
  end
end
