# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def line
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      flash[:notice] = "ログインしました。"
      sign_in_and_redirect @user
    else
      @user.save
      sign_in_and_redirect @user
    end
  end
end
