require "rails_helper"

describe "投稿機能", type: :system do
  before do
    user_a = create(:user, name: "ユーザーA", email: "a@example.com")
    user_b = create(:user, name: "ユーザーB", email: "b@example.com")
    post_a = create(:post, title: "タイトルA", description: "Aの投稿です", user: user_a)
    post_b = create(:post, title: "タイトルB", description: "Bの投稿です", user: user_b)
    user_a.comments.create!(content: "コメントA", post: post_b)
    visit login_path
    fill_in "Email", with: "a@example.com"
    fill_in "Password", with: "password"
    click_button "login"
  end

  describe "投稿一覧機能" do
    before do
      visit posts_path
    end

    it "投稿Aが表示される" do
      expect(page).to have_content "タイトルA"
    end

    it "投稿Bが表示される" do
      expect(page).to have_content "タイトルB"
    end
  end

  describe "投稿詳細機能" do
    before do
      visit posts_path
      click_link "タイトルB"
    end

    it "投稿Bの詳細が表示される" do
      expect(page).to have_content "Bの投稿です"
    end

    it "Aのコメントが表示される" do
      expect(page).to have_content "コメントA"
    end
  end

  describe "投稿編集機能" do
    before do
      visit profile_path
      click_link "編集"
    end

    it "投稿Aを編集する" do
      # TitleにタイトルAが入力されていることを確認
        expect(page).to have_field "Title", with: "タイトルA"
      # Descriptionにが入力されていることを確認
        expect(page).to have_field "Description", with: "Aの投稿です"

        fill_in "Title", with: "編集済み投稿A"
        fill_in "Description", with: "詳細を編集した"
        click_button "投稿"

        # 投稿を編集しましたと表示されるか確認
        expect(page).to have_content "投稿を編集しました"
        # 編集済み投稿Aが表示されていることを確認
        expect(page).to have_content "編集済み投稿A"
    end
  end

  describe "投稿削除機能" do
    before do
      visit profile_path
      click_link "削除"
    end

    it "投稿Aを削除する" do
       # ダイアログの確認、削除後のメッセージの確認、postが減っているのを確認
       expect {
         page.accept_confirm "投稿削除します。よろしいですか？"
         expect(page).to have_content "投稿を削除しました"
       }.to change { Post.count }.by(-1)
    end
  end
end
