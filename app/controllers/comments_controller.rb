class CommentsController < ApplicationController
  
  def create
    @comment = current_user.comments.build(comment_params)
    @record = @comment.record
    @comment.save
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(record_id: params[:record_id])
  end

end
