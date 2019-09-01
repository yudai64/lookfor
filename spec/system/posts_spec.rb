require "rails_helper"

describe "投稿機能", type: :system do
  let(:user) { create(:user) }

  before do
    post = create(:post, user: user)
    create(:comment, user: user, post: post)
    login(user)
  end

  describe "新規投稿機能" do
    before do
      visit new_post_path
      fill_in "Title", with: post_title
      fill_in "Description", with: post_description
      click_button "投稿"
    end

    context "どちらも入力したとき" do
      let(:post_title) { "新規投稿のタイトル" }
      let(:post_description) { "新規投稿の詳細" }

      it "正常に投稿される" do
        expect(page).to have_content "新規投稿のタイトル"
      end
    end

    context "Titleが空欄のとき" do
      let(:post_title) { "" }
      let(:post_description) { "新規投稿のタイトル" }

      it "失敗する" do
        expect(page).to have_content "can't be blank"
      end
    end

    context "Descriptionが空欄のとき" do
      let(:post_title) { "新規投稿の詳細" }
      let(:post_description) { "" }

      it "失敗する" do
        expect(page).to have_content "can't be blank"
      end
    end
  end

  describe "投稿一覧機能" do
    before do
      user_b = create(:user, name: "ユーザーB", email: "b@example.com")
      create(:post, title: "タイトルB", description: "Bの投稿です", user: user_b)
      visit posts_path
    end

    it "テスト投稿が表示される" do
      expect(page).to have_content "テスト投稿"
    end

    it "投稿Bが表示される" do
      expect(page).to have_content "タイトルB"
    end
  end

  describe "投稿詳細機能" do
    before do
      visit posts_path
      click_link "テスト投稿"
    end

    it "テスト投稿の詳細が表示される" do
      expect(page).to have_content "これはテスト詳細です"
    end

    it "テスト投稿のコメントが表示される" do
      expect(page).to have_content "テストコメント"
    end
  end

  describe "投稿編集機能" do
    before do
      visit profile_path
      click_link "編集"
    end

    it "投稿は編集される" do
      expect(page).to have_field "Title", with: "テスト投稿"

      expect(page).to have_field "Description", with: "これはテスト詳細です"

      fill_in "Title", with: "編集済み投稿"
      fill_in "Description", with: "詳細を編集した"
      click_button "投稿"

      expect(page).to have_content "投稿を編集しました"

      expect(page).to have_content "編集済み投稿"
    end
  end

  describe "投稿削除機能" do
    before do
      visit profile_path
      click_link "削除"
    end

    context "OKを押した場合" do
      it "テスト投稿は削除される" do
        page.accept_confirm "投稿削除します。よろしいですか？"

        expect(page).to have_content "投稿を削除しました"

        expect(page).not_to have_content "テスト投稿"
      end
    end

    context "キャンセルを押した場合" do
      it "投稿Aは削除されない" do
        page.dismiss_confirm "投稿削除します。よろしいですか？"

        expect(page).to have_content "テスト投稿"
      end
    end
  end
end
