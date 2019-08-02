module ApplicationHelper
  private

  #ユーザーログインする
  def login_user(user)
    session[:user_id] = user.id
  end

  #与えられたユーザーが、今ログインしているユーザーならtrueを返す
  def current_user?(user)
    user == current_user
  end

end
