require 'rails_helper'

describe AnswersController do
  let(:question) {Question.create(title: "Test Title", body: "Test Body", user_id: 1)}
  describe 'GET#new' do
    let(:answer) {question.answers.build(body: "test body")}
    it 'is successful' do
      get :new, question_id: question.id
      expect(response).to be_success
    end

    it 'assigns @answer to an answer' do
      get :new, question_id: question.id
      expect(assigns(:answer)).to be_a_new Answer
    end
  end

  describe 'POST#create' do
    it 'creates with valid attributes' do
      expect{
        post :create, question_id: question.id, answer: {body: "test", user_id: 1}
      }.to change {Answer.count}.by(1)
      expect(response).to be_redirect
    end

    it "doesn't create if attributes are invalid" do
      expect{
        post :create, question_id: question.id, answer: {body: nil, user_id: 1}
      }.not_to change {Answer.count}
      expect(response).not_to be_redirect
    end
  end

  describe 'GET#edit' do
    let(:answer) {question.answers.build(body: "test", user_id: 1)}
    it 'is successful' do
      answer.save
      get :edit, question_id: question.id, id: answer.id
      expect(response).to be_success
    end

    it 'assigns @answer to the Answer found by id' do
      answer.save
      get :edit, question_id: question.id, id: answer.id
      expect(assigns(:answer)).to eq answer
    end
  end
end