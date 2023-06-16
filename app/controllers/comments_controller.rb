class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_concern
  before_action :set_comment, only: [:destroy]

  def create
    @comment = @concern.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @concern, notice: 'Comment added successfully.'
    else
      redirect_to @concern, alert: 'Failed to add comment.'
    end
  end

  def destroy
    @comment.destroy
    redirect_to @concern, notice: 'Comment deleted successfully.'
  end

  private

  def set_concern
    @concern = Concern.find(params[:concern_id])
  end

  def set_comment
    @comment = @concern.comments.find(params[:id])
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
