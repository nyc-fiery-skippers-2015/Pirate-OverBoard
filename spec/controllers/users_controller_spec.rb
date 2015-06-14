require 'rails_helper'
describe UsersController do
  let(:test_user){create(:user)}
  before :each do
    @request.session[:user_id] = test_user.id
      end
  describe 'GET#new' do
    it "is successful"do
      get :new
      expect(response).to be_success
    end
    it "assigns @user to User.new" do
     get :new
     expect(assigns(:user)).to be_a_new User
    end
  end
  describe 'GET#show'do
  it 'is successful' do
    get :show, id: test_user.id
    expect(response).to be_success
  end

  it 'assigns @user to the user found by id' do
      get :show, id: test_user.id
    expect(assigns(:user)).to eq test_user
  end
 end
 describe 'POST#create' do
  it "creates with valid attributes" do
   expect { post :create, user: {username:'don',email:"test",password_digest:"12334"}}. to change {User.count}.by(1)
   expect(response).to be_redirect
   end
 end


 describe'GET#edit' do
   it"succesful edit" do
    get :edit, id: test_user.id
    expect(response).to be_success
  end
   it "assigns @user to the user found by id" do
    get :edit, id: test_user.id
    expect(assigns(:user)).to eq test_user
   end
  end
# describe 'Put#update'do
#  it "updates current user seeting"do
#   expect{put :update id:test_user.id,
#   :user=>{email:"don@gmail.com"}.to change{question reload.email}.to("don@gmail.com")expect(response).to be_redirect
# end
# end


end

