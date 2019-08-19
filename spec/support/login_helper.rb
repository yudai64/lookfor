module LoginHelpers
  # ユーザーAでログインする
  def login
    visit login_path
    fill_in "Email", with: "a@example.com"
    fill_in "Password", with: "password"
    click_button "login"
  end
end
