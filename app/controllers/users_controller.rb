class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to user_url(@user), notice: "登録しました"
    else
      render :new
    end
  end

  def edit
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :word, :url)
    end

end
