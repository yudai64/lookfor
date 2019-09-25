# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def line
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      flash[:notice] = "ログインしました。"
      sign_in_and_redirect @user
    else
      @user.save!
      flash[:notice] = "新規登録しました。"
      sign_in_and_redirect @user
    end
  end
end
