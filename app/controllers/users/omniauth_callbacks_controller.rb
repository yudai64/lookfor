# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def line; basic_action end

  private

    def basic_action
     @omniauth = request.env['omniauth.auth']
     if @omniauth.present?
       @profile = User.where(provider: @omniauth['provider'], uid: @omniauth['uid']).first
       if @profile
         @profile.set_values(@omniauth)
         sign_in(:user, @profile)
       else
         @profile = User.new(provider: @omniauth['provider'], uid: @omniauth['uid'])
         @profile = current_user || User.create!(provider: @omniauth['provider'], uid: @omniauth['uid'], name: @omniauth['info']['name'], password: Devise.friendly_token[0, 20])
         @profile.set_values(@omniauth)
         sign_in(:user, @profile)
         # redirect_to edit_user_path(@profile.user.id) and return
       end
     end
     flash[:notice] = "ログインしました"
     redirect_to root_path
    end
end
