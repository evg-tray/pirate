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
  end
end
