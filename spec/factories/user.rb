FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    email{Faker::Internet.email}
    password{Faker::Lorem.characters(number:10)}
  end
end