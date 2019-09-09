class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  helper_method :current_user, :logged_in?, :current_user?
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :age])
    end

    # ユーザーログインする
    def login_user(user)
      session[:user_id] = user.id
    end

    # 与えられたユーザーが、今ログインしているユーザーならtrueを返す
    def current_user?(user)
      user == current_user
    end

    # ログインしているユーザー所得する
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    # ログインしていればtrueしていなければfalseを返す
    def logged_in?
      current_user.present?
    end

    # ログイン済みユーザーかどうか確認
    def authenticate_user
      redirect_to login_path, danger: "ログインしてください" unless logged_in?
    end
end
