FactoryBot.define do
  factory :comment do
    comment { Faker::Lorem.characters(number: 25) }
    user
    post
  end
end
