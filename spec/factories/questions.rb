FactoryGirl.define do
  factory :question do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.sentence }
    user
  end
end
