FactoryGirl.define do
  factory :manufacturer do
    name { Faker::Lorem.characters(20) }
    short_name { Faker::Lorem.characters(3) }
  end
end
