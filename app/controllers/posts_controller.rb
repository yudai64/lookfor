class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
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
  end

  private

    def post_params
      params.require(:post).permit(:title, :description)
    end
end
