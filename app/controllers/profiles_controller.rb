class ProfilesController < ApplicationController
  def show
    @user = current_user
  end

  def edit
  end

  def update
    @user = current_user

    if @user.update(user_params)
      redirect_to "/profile", success: "編集しました"
    else
      render :edit
    end
  end

  def destroy
    @user = current_user
    @user.destroy
    redirect_to root_url, success: "ユーザー削除しました"
  end
end
