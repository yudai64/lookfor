class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: login_params[:email])

    if @user&.authenticate(login_params[:password])
      login_user(@user)
      redirect_to @user, success: "ログインしました"
    else
      flash.now[:danger] = "メールとパスワードの組み合わせが正しくありません"
      render :new
    end
  end

  def destroy
    reset_session
    flash[:success] = "ログアウトしました"
    redirect_to login_path
  end

  private

    def login_params
      params.require(:session).permit(:email, :password)
    end
end
