class ProfilesController < ApplicationController
  def show
    @posts = current_user.posts.order(updated_at: "DESC")
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to profile_path, success: "編集しました"
    else
      render :edit
    end
  end

  def destroy
    current_user.destroy
    redirect_to root_url, success: "ユーザー削除しました"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :word, :url)
  end

end
