FactoryGirl.define do
  factory :flavor do
    name { Faker::Lorem.characters(15) }
    manufacturer
  end
end
