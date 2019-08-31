require "rails_helper"

describe "ユーザー機能", type: :system do
  let(:user) { create(:user) }

  before do
    create(:post, user: user)
    login(user)
  end

  describe "全ユーザー一覧表示機能" do
    before do
      create(:user, name: "ユーザーB", email: "b@example.com")
      visit users_path
    end

    it "テストユーザーが表示される" do
      expect(page).to have_content "テストユーザー"
    end

    it "ユーザーBが表示される" do
      expect(page).to have_content "ユーザーB"
    end
  end

  describe "全ユーザー詳細画面" do
    before do
      visit users_path
      click_link "テストユーザー"
    end

    it "テストユーザーが表示される" do
      expect(page).to have_content "テストユーザー"
    end

    it "テスト投稿は表示されない" do
      expect(page).not_to have_content "テスト投稿"
    end
  end

  describe "自ユーザー詳細画面" do
    before do
      visit profile_path
    end

    it "テストユーザーが表示される" do
      expect(page).to have_content "テストユーザー"
    end

    it "テスト投稿が表示される" do
      expect(page).to have_content "テスト投稿"
    end
  end

  describe "自ユーザー編集機能" do
    before do
      visit profile_path
      visit edit_profile_path
    end

    it "テストユーザーを編集する" do
      expect(page).to have_field "Name", with: "テストユーザー"

      expect(page).to have_field "Email", with: "test@example.com"

      fill_in "Name", with: "編集済みユーザー"
      fill_in "Email", with: "edit@example.com"
      click_button "Update User"

      expect(page).to have_content "編集しました"

      expect(page).to have_content "編集済みユーザー"
    end
  end

  describe "自ユーザー削除機能" do
    before do
      visit profile_path
      click_link "delete account"
    end

    context "OKを押した場合" do
      it "テストユーザーは削除される" do
        page.accept_confirm "アカウント削除します。よろしいですか？"

        expect(page).to have_content "ユーザー削除しました"

        expect(page).not_to have_content "テストユーザー"
      end
    end

    context "キャンセルを押した場合" do
      it "ユーザーAは削除されない" do
        page.dismiss_confirm "アカウント削除します。よろしいですか？"

        expect(page).to have_content "テストユーザー"
      end
    end
  end
end
