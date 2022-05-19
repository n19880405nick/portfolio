class Public::CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = params[:post_id]
    @comment.save
    redirect_to post_path(@comment.post_id)
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to post_path(comment.post_id)
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
