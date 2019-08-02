class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: session_params[:email])

    if @user&.authenticate(session_params[:password])
      session[:user_id] = @user.id
      flash[:success] = "ログインしました"
      redirect_to @user
    else
      flash.now[:danger] = "メールとパスワードの組み合わせが正しくありません"
      render :new
    end
  end

  private

    def session_params
      params.require(:session).permit(:email, :password)
    end
end
