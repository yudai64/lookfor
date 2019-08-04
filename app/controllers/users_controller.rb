class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :create,]
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login_user(@user)
      redirect_to "/profile", success: "登録しました"
    else
      render :new
    end
  end

  def edit
    @user = current_user
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

  def profile
    @user = current_user
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :word, :url)
    end

end
