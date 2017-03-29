FactoryGirl.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password }
    username { Faker::Internet.unique.user_name }

    factory :user_admin do
      after(:create) { |user| user.add_role(:admin) }
    end

    factory :user_moderator do
      after(:create) { |user| user.add_role(:moderator) }
    end
  end
end
