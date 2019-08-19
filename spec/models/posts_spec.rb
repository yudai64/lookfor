require "rails_helper"

RSpec.describe Post, type: :model do
  describe "#create" do
    it "is valid with a title, description" do
      post = build(:post)
      expect(post).to be_valid
    end

    it "is invalid without a title" do
      post = build(:post, title: nil)
      expect(post).not_to be_valid
    end

    it "is invalid without a description" do
      post = build(:post, description: nil)
      expect(post).not_to be_valid
    end
  end

  describe "Association" do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context "user" do
      let(:target) { :user }

      it { expect(association.macro).to eq :belongs_to }

      it { expect(association.class_name).to eq "User"}
    end

    context "comment" do
      let(:target) { :comments }

      it { expect(association.macro).to eq :has_many }

      it { expect(association.class_name).to eq "Comment" }

      it "destroyed when post destroyed" do
        user = create(:user)
        post = create(:post, user: user)
        user.comments.create!(content: "コメントです", post: post)
        expect{ post.destroy }.to change{ Comment.count }.by(-1)
      end
    end


  end
end
