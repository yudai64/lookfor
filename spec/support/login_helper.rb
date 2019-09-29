module LoginHelpers
  # ログインする
  def login(user)
    OmniAuth.config.mock_auth[:line] = nil
    Rails.application.env_config["omniauth.auth"] = line_mock(user)
    visit user_line_omniauth_authorize_path
    click_button "ログイン"
  end
end
