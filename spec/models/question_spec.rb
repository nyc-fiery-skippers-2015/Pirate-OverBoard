require 'rails_helper'

describe Question do 
  it 'is valid with body and title' do 
    good_q = Question.new(title: 'test', body: 'test body')
    expect(good_q).to be_valid
  end

  it 'is invalid without body and title' do 
    bad_q = Question.new(title: 'test', body: nil)
    bad_q.valid?
    expect(bad_q.errors[:body]).to include("can't be blank")
  end
end