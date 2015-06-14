FactoryGirl.define do
  factory :answer do
    body { Faker::Lorem.sentence }
    user
    question
  end

  factory :answer_comment, class: "Comment" do
    association :commentable, factory: :answer
    body { Faker::Lorem.sentence }
    user
  end

  factory :answer_vote, class: "Vote" do
    association :votable, factory: :answer
    vote_count{1}
    user
  end

end
