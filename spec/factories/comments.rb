FactoryGirl.define do
  factory :comment do
    association :author, factory: :user
    recipe
    text { Faker::Lorem.characters(30) }
  end
end
