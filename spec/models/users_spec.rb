require "rails_helper"

describe User do
  describe "#create" do
    it "is valid with a name, email, password, password_confirmation" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "is invalid without a name" do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
    end

    it "is invalid a name that has more than 13 characers" do
      user = build(:user, name: "aaaaaaaaaaaaa")
      expect(user).not_to be_valid
    end

    it "is invalid without a password" do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it "is invalid duplicate email address" do
      user = create(:user)
      user2 = build(:user, name: "user2", email: "test@example.com", password: "password2", password: "password2")
      user2.valid?
      expect(user2.valid?).to eq(false)
    end

    it "is invalid without a password" do
      user = build(:user, password: nil)
      expect(user).not_to be_valid
    end

    it "is invalid without a password_confirmation" do
      user = build(:user, password: nil)
      expect(user).not_to be_valid
    end

    it "is invalid with password_confirmation that do not match password" do
      user = build(:user, password_confirmation: "password2")
      user.valid?
      expect(user.valid?).to eq(false)
    end
  end
end
