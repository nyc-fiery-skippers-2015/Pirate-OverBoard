FactoryGirl.define do
  factory :question do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.sentence }
    user
  end

  factory :user do
    user_name { Faker::Internet.user_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end

end
