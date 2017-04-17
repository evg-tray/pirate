FactoryGirl.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password }
    username { Faker::Internet.unique.user_name }
    subscribed false

    factory :user_admin do
      after(:create) { |user| user.add_role(:admin) }
    end

    factory :user_moderator do
      after(:create) { |user| user.add_role(:moderator) }
    end

    factory :user_confirmed do
      after(:create) do |user|
        user.confirmed_at = Time.now
        user.save
      end
    end
  end
end
