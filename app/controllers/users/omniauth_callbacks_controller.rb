# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def line
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      flash[:notice] = "ログインしました。"
      sign_in_and_redirect @user
    else
      session["devise.#{line}_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
