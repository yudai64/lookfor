class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user, only: [:index]
  def index
    @posts = Post.all.order(updated_at: "DESC")
  end

  def show
    @comments = @post.comments.includes(:user)
    @comment = current_user.comments.build
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, success: '投稿しました'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to profile_path, success: "投稿を編集しました"
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to profile_path, success: "投稿を削除しました"
  end

  private

    def post_params
      params.require(:post).permit(:title, :description)
    end

    def find_post
      @post = Post.find(params[:id])
    end
end
