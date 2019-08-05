class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :create]

  def new
  end

  def create
    @user = User.find_by(email: login_params[:email])

    if @user&.authenticate(login_params[:password])
      login_user(@user)
      redirect_to profile_path, success: "ログインしました"
    else
      flash.now[:danger] = "メールとパスワードの組み合わせが正しくありません"
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to login_path, success: "ログアウトしました"
  end

  private

    def login_params
      params.require(:session).permit(:email, :password)
    end
end
