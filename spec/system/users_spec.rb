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
      visit edit_user_registration_path
    end

    it "ユーザーは編集される" do
      expect(page).to have_field "名前", with: "テストユーザー"

      expect(page).to have_field "メールアドレス", with: "test@example.com"

      fill_in "名前", with: "編集済みユーザー"
      fill_in "メールアドレス", with: "edit@example.com"
      fill_in "現在のパスワード", with: "password"
      click_button "Update"

      expect(page).to have_content "アカウント情報を変更しました。"
    end
  end

  describe "自ユーザー削除機能" do
    before do
      visit profile_path
      visit edit_user_registration_path
      click_button "アカウント削除"
    end

    context "OKを押した場合" do
      it "テストユーザーは削除される" do
        page.accept_confirm "アカウント削除します。よろしいですか？"

        expect(page).to have_content "アカウントを削除しました。またのご利用をお待ちしております。"
      end
    end

    context "キャンセルを押した場合" do
      it "ユーザーAは削除されない" do
        page.dismiss_confirm "アカウント削除します。よろしいですか？"

        expect(page).to have_content "アカウントを削除する"
      end
    end
  end
end
