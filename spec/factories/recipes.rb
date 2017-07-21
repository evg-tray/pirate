FactoryGirl.define do
  factory :recipe do
    name { Faker::Lorem.characters(20) }
    amount 10
    strength 1.5
    pg 30
    vg 70
    nicotine_base 100
    public false
    pirate_diy false
    association :author, factory: :user
    average_rating 0.0
    count_rating 0
    after(:build) do |rec|
      rec.flavors_recipes << build(:flavors_recipe)
    end

    trait :public do
      public true
    end

    trait :pirate_diy do
      pirate_diy true
    end

    factory :public_recipe, traits: [:public]
    factory :pirate_diy_recipe, traits: [:pirate_diy]
  end
end
