class PostsController < ApplicationController
  def index
    @posts = Post.all.order(updated_at: "DESC")
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to posts_path, success: '投稿しました'
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to profile_path, success: "投稿を編集しました"
    else
      render :edit
    end
  end

  private

    def post_params
      params.require(:post).permit(:title, :description)
    end
end
