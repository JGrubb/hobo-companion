require 'spec_helper'

describe User do
  before :each do
    @user = User.new(
      email: "test@example.com",
      password: "12345678"
    )
  end

  it "is valid with an email, password, and password confirmation" do
    expect(@user).to be_valid
  end

  it "is invalid without an email" do
    @user.email = nil
    expect(@user).to be_invalid
  end

  it "is invalid without a password" do
    @user.password = nil
    expect(@user).to be_invalid
  end

  it "is invalid with an incorrect password conf" do
    @user.password_confirmation = "incorrect conf"
    expect(@user).to be_invalid
  end
end
