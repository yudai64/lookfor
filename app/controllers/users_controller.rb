class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :create,]
  before_action :correct_user, only: [:edit, :update, :destroy]
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
      redirect_to user_url(@user), success: "登録しました"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to user_url(@user), success: "編集しました"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_url, success: "ユーザー削除しました"
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :word, :url)
    end

    #beforeフィルター

    #権限がない場合、自分のページに返す
    def correct_user
      @user = User.find(params[:id])
      redirect_to current_user, danger: "権限がありません" unless current_user?(@user)
    end

end
