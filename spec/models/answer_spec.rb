require 'rails_helper'

describe Answer do
  let(:answer) {FactoryGirl.build(:answer)}

  subject{ answer }
  it { should be_valid }

  it 'is invalid without a body' do
    answer2 = Answer.new(body: nil)
    answer2.valid?
    expect(answer2.errors[:body]).to include("can't be blank")
  end
end

describe 'Answer Comments' do
  let(:answer) { FactoryGirl.build(:answer) }
  let(:answer_comment) { FactoryGirl.create(:answer_comment, commentable: answer) }

  subject{ answer_comment }

  it { should be_valid }

  it { should respond_to(:body) }
  it { should respond_to(:commentable) }
end

describe 'Answer Votes' do
  let(:answer) { FactoryGirl.build(:answer) }
  let(:answer_vote) { FactoryGirl.create(:answer_vote, votable: answer) }

  subject{ answer_vote }

  it { should be_valid }

  it { should respond_to(:vote_count) }
  it { should respond_to(:votable) }
end