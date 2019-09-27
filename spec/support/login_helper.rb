module LoginHelpers
  # ログインする
  def login(user)
    visit new_user_session_path
    click_button " Log in "
    click_button "ログイン"
  end
end
