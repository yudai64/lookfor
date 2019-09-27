module LoginHelpers
  # ログインする
  def login(user)
    visit user_line_omniauth_authorize_path
    click_button "ログイン"
  end
end
