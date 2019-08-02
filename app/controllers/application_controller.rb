class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  helper_method :current_user, :logged_in?
  before_action :authenticate_user

  private

  #ログインしているユーザー所得する
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  #ログインしていればtrueしていなければfalseを返す
  def logged_in?
    current_user.present?
  end

  #ログイン済みユーザーかどうか確認
  def authenticate_user
    redirect_to login_path, danger: "ログインしてください" unless logged_in?
  end

end
