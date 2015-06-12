FactoryGirl.define do
  factory :user do
    username {Faker::Internet.user_name}
    email {Faker::Internet.email}
    password_digest {Faker::Internet.password(6)}
  end

end
