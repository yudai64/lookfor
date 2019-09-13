module LoginHelpers
  # ログインする
  def login(user)
    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "Sign in"
  end
end
