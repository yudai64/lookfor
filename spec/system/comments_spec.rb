require "rails_helper"

describe "コメント機能", type: :system do
  let(:post) { create :post }
  
  before do
    login(post.user)
    visit posts_path
    click_link "テストです"
    fill_in "Content", with: content
    click_button "送信"
  end

  context "入力したとき" do
    let(:content) { "コメントA" }

    it "コメントが表示される" do
      expect(page).to have_content "コメントA"
    end
  end

  context "空欄で送信したとき" do
    let(:content) { "" }

    it "失敗する" do
      expect(page).to have_content "コメント出来ませんでした"
    end
  end
end
