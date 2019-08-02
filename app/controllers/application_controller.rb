class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  helper_method :current_user, :logged_in?


  private
    #ユーザーログインする
    def login_user(user)
      session[:user_id] = user.id
    end

    #ログインしているユーザー所得する
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    #ログインしていればtrueしていなければfalseを返す
    def logged_in?
      !current_user.nil?
    end
end
