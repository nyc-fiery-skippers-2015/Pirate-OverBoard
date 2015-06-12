require 'rails_helper'

describe QuestionsController do 
  let(:question) {FactoryGirl.create(:question)}

  describe 'GET#index' do 
    it 'is successful' do 
      get :index
      expect(response).to be_success
    end

    it 'assigns @questions to Question.all' do 
      get :index
      expect(assigns(:questions)).to eq Question.all
    end
  end

  describe 'GET#show' do 
    it 'is successful' do 
      get :show, id: question.id
      expect(response).to be_success
    end

    it 'assigns @question to the question found_by id' do 
      get :show, id: question.id
      expect(assigns(:question)).to eq question
    end
  end

  describe 'GET#new' do 
     it 'is successful' do 
      get :new
      expect(response).to be_success
    end

    it 'assigns @questions to Question.new' do 
      get :new
      expect(assigns(:question)).to be_a_new Question
    end
  end  

  describe 'POST#create' do 
    it "creates with valid attributes" do
      expect {
        post :create, question: {title: 'test', body: 'test body', user_id: 1}
      }.to change { Question.count }.by(1)
      expect(response).to be_redirect
    end

    it "doesn't create if attributes are invalid" do
      expect {
        post :create, question: {title: nil, body: nil}
      }.not_to change { Question.count }
      expect(response).not_to be_redirect
    end
  end

  describe 'GET#edit' do 
      let(:question) { FactoryGirl.create :question }
    it "is successful" do
      get :edit, :id => question.id
      expect(response).to be_success
    end

    it "assigns @question to the question found by id" do
      get :edit, :id => question.id
      expect(assigns(:question)).to eq question
    end
  end

  describe 'PUT#update' do 
     let!(:question) { FactoryGirl.create :question }
    it "updates with valide attributes" do
      expect {
        put :update, :id => question.id, :question => {:title => "bad"}
      }.to change { question.reload.title }.to("bad")
      expect(response).to be_redirect
    end

    it "doesn't update if attributes are invalid" do
      expect {
        put :update, :id => question.id, :question => {:title => nil}
      }.to_not change { question.reload.title }
      expect(response).not_to be_redirect
    end
  end

  describe 'DELETE#destroy' do 
        let!(:question) {FactoryGirl.create :question}
    it 'should delete the question' do
      expect {
        delete :destroy, id: question.id
      }.to change { Question.count }.by(-1)
      expect(response).to be_redirect
    end
  end

end