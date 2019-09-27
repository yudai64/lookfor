module LoginHelpers
  # ログインする
  def login(user)
    visit new_user_session_path
    click_link "LINE"
    click_button "ログイン"
  end
end
