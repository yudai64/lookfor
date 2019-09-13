class ProfilesController < ApplicationController
  def show
    @posts = current_user.posts.order(updated_at: "DESC")
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :word, :url)
    end
end
