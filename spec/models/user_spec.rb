require 'rails_helper'

describe User do
  it "User should be a uniqu user" do
    user_one = create(:user)
    user_two = build(:user, username:user_one.username, email:user_one.email)
    user_two.valid?
    expect(user_two.erros[:username]).to include('has already been taken')
  end
  it "is invalid without an email address"
  it "user should have a pasword"

end
