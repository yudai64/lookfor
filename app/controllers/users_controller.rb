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

end
