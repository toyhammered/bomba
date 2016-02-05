class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      track_activity(@comment)
      flash[:notice] = "Comment saved successfully."
    else
      flash[:error] = "Comment failed to save."
    end

    redirect_to :back
  end

  def destroy
  end

  def upvote
    @comment = Comment.find(params[:id])
    @comment.liked_by current_user
    redirect_to :back
  end

  def downvote
    @comment = Comment.find(params[:id])
    @comment.disliked_by current_user
    redirect_to :back
  end


  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
