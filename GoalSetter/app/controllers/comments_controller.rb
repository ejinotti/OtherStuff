class CommentsController < ApplicationController

  def new
    @comment = Comment.new
    render :new
  end

  def create
    # @comment = Comment.new(comment_params)
    # @comment.author_id = current_user.id

    @comment = current_user.authored_comments.new(comment_params)

    if @comment.save
      if @comment.commentable_type == "User"
        redirect_to user_url(@comment.commentable)
      else
        redirect_to user_url(@comment.commentable.user)
      end
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type)
  end
end
