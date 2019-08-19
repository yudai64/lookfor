require "rails_helper"

describe "コメント機能", type: :system do
  before do
    user_a = create(:user, name: "ユーザーA", email: "a@example.com")
    user_b = create(:user, name: "ユーザーB", email: "b@example.com")
    post_b = create(:post, title: "タイトルB", description: "Bの投稿です", user: user_b)
    visit login_path
    fill_in "Email", with: "a@example.com"
    fill_in "Password", with: "password"
    click_button "login"
  end

  describe "新規コメント作成機能" do
    before do
      visit posts_path
      click_link "タイトルB"
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
end
