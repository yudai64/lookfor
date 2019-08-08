class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "コメントしました"
      redirect_back(fallback_location: @post)
    else
      flash[:danger] = "コメント出来ませんでした"
      redirect_back(fallback_location: @post)
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end
end
