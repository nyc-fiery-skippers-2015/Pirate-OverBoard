require 'rails_helper'

describe User do
  it "User should be a unique user" do
    user_one = create(:user)
    user_two = build(:user, username:user_one.username, email:user_one.email)
    expect(user_two.valid?).to eq (false)
  end
  it "is invalid without an email address"do
      user = build(:user, email: nil )
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
  end


end
