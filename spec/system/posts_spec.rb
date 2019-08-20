require "rails_helper"

describe "投稿機能", type: :system do
  before do
    user_a = create(:user, name: "ユーザーA", email: "a@example.com")
    user_b = create(:user, name: "ユーザーB", email: "b@example.com")
    post_a = create(:post, title: "タイトルA", description: "Aの投稿です", user: user_a)
    post_b = create(:post, title: "タイトルB", description: "Bの投稿です", user: user_b)
    user_a.comments.create!(content: "コメントA", post: post_b)
    login
  end

  describe "新規投稿一覧機能" do
    before do
      visit new_post_path
      fill_in "Title", with: post_title
      fill_in "Description", with: post_description
      click_button "投稿"
    end

    context "どちらも入力したとき" do
      let(:post_title) { "テスト投稿" }
      let(:post_description) { "テスト投稿です" }

      it "正常に投稿される" do
        expect(page).to have_content "テスト投稿"
      end
    end

    context "Titleが空欄のとき" do
      let(:post_title) { "" }
      let(:post_description) { "テスト投稿です" }

      it "失敗する" do
        expect(page).to have_content "can't be blank"
      end
    end

    context "Descriptionが空欄のとき" do
      let(:post_title) { "テスト投稿" }
      let(:post_description) { "" }

      it "失敗する" do
        expect(page).to have_content "can't be blank"
      end
    end

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

    context "OKを押した場合" do
      it "投稿Aは削除される" do
         page.accept_confirm "投稿削除します。よろしいですか？"

         expect(page).to have_content "投稿を削除しました"

         expect(page).not_to have_content "タイトルA"
       end
     end

     context "キャンセルを押した場合" do
       it "投稿Aは削除されない" do
          page.dismiss_confirm "投稿削除します。よろしいですか？"

          expect(page).to have_content "タイトルA"
        end
      end
  end
end
