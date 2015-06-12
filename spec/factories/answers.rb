FactoryGirl.define do
  factory :answer do
    body { Faker::Lorem.sentence }
  end

end
