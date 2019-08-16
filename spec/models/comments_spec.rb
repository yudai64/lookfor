require "rails_helper"

RSpec.describe Comment, type: :model do
  describe "#create" do
    it "is valid with a content" do
      comment = build(:comment)
      expect(comment).to be_valid
    end

    it "is valid without a content" do
      comment = build(:comment, content: nil)
      expect(comment).not_to be_valid
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

    context "post" do
      let(:target) { :post }

      it { expect(association.macro).to eq :belongs_to }

      it { expect(association.class_name).to eq "Post" }
    end
  end
end
