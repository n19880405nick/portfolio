FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(number: 10) }
    contribution { Faker::Lorem.characters(number: 100) }
    user
  end
end
