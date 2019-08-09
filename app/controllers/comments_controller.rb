class CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = post.comments.build(comment_params)
    comment.user_id = current_user.id
    if comment.save
      redirect_back fallback_location: post, success: "コメントしました"
    else
      redirect_back fallback_location: post, danger: "コメント出来ませんでした"
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end
end
