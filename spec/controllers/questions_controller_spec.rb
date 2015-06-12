require 'rails_helper'

describe QuestionsController do 

  describe 'GET#index' do 
    it 'is successful' do 
      get :index
      expect(response).to be_success
    end

    it 'assigns @questions to Question.all' do 
      get :index
      expect(assigns(:questions)).to eq Questions.all
    end
  end

  describe 'GET#show' do 
    let(:question) {FactoryGirl.create(:question)}
    it 'is successful' do 
      get :show, id: question.id
      expect(response).to be_success
    end

    it 'assigns @question to the question found_by id' do 
      get :show, id: question.id
      expect(assigns(:question)).to eq question
    end
  end








end