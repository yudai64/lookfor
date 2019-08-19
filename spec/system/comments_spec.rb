require "rails_helper"

describe "コメント機能", type: :system do
  before do
    user_a = create(:user, name: "ユーザーA", email: "a@example.com")
    create(:post, title: "タイトルA", description: "Aの投稿です", user: user_a)
    login
    visit posts_path
    click_link "タイトルA"
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
