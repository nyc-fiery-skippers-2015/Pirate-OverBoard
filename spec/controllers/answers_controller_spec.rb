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
end