FactoryGirl.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password }
    username { Faker::Internet.unique.user_name }
    subscribed false
    confirmed_at Time.now

    factory :user_admin do
      after(:create) { |user| user.add_role(:admin) }
    end

    factory :user_moderator do
      after(:create) { |user| user.add_role(:moderator) }
    end

    factory :user_flavor_creator do
      after(:create) { |user| user.add_role(:flavor_creator) }
    end

    factory :user_pirate_diy_creator do
      after(:create) { |user| user.add_role(:pirate_diy_creator) }
    end
  end
end
