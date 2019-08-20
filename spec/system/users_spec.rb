require "rails_helper"

describe "ユーザー機能", type: :system do
  before do
    user_a = create(:user, name: "ユーザーA", email: "a@example.com")
    create(:post, title: "タイトルA", user: user_a)
    login(user_a)
  end

  describe "全ユーザー一覧表示機能" do
    before do
      user_b = create(:user, name: "ユーザーB")
      visit users_path
    end

    it "ユーザーAが表示される" do
      expect(page).to have_content "ユーザーA"
    end

    it "ユーザーBが表示される" do
      expect(page).to have_content "ユーザーB"
    end
  end

  describe "全ユーザー詳細画面" do
    before do
      visit users_path
      click_link "ユーザーA"
    end

    it "ユーザーAが表示される" do
      expect(page).to have_content "ユーザーA"
    end

    it "投稿Aは表示されない" do
      expect(page).not_to have_content "タイトルA"
    end
  end

  describe "自ユーザー詳細画面" do
    before do
      visit profile_path
    end

    it "ユーザーAが表示される" do
      expect(page).to have_content "ユーザーA"
    end

    it "投稿Aが表示される" do
      expect(page).to have_content "タイトルA"
    end
  end

  describe "自ユーザー編集機能" do
    before do
      visit profile_path
      visit edit_profile_path
    end

    it "ユーザーAを編集する" do
    # NameにユーザーAが入力されていることを確認
      expect(page).to have_field "Name", with: "ユーザーA"
    # Emailにa@example.comが入力されていることを確認
      expect(page).to have_field "Email", with: "a@example.com"

      fill_in "Name", with: "編集済みユーザーA"
      fill_in "Email", with: "aaa@example.com"
      click_button "Update User"

      # 編集しましたと表示されるか確認
      expect(page).to have_content "編集しました"
      # 編集済みユーザーAが表示されていることを確認
      expect(page).to have_content "編集済みユーザーA"
    end
  end

  describe "自ユーザー削除機能" do
    before do
      visit profile_path
      click_link "delete account"
    end

    context "OKを押した場合" do
      it "ユーザーAは削除される" do
        page.accept_confirm "アカウント削除します。よろしいですか？"

        expect(page).to have_content "ユーザー削除しました"

        expect(page).not_to have_content "ユーザーA"
      end
    end

    context "キャンセルを押した場合" do
      it "ユーザーAは削除されない" do
        page.dismiss_confirm "アカウント削除します。よろしいですか？"

        expect(page).to have_content "ユーザーA"
      end
    end
  end
end
