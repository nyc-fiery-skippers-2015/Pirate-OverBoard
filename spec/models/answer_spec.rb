require 'rails_helper'

describe Answer do
  let(:answer) {FactoryGirl.build(:answer)}

  it 'is valid with a body' do
    expect(answer).to be_valid
  end

  it 'is invalid without a body' do
    answer2 = Answer.new(body: nil)
    answer2.valid?
    expect(answer2.errors[:body]).to include("can't be blank")
  end
end