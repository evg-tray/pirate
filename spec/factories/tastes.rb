FactoryGirl.define do
  factory :taste do
    name { Faker::Lorem.characters(20) }
  end
end
