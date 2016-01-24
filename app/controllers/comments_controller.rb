class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      flash[:notice] = "Comment saved successfully."
    else
      flash[:error] = "Comment failed to save."
    end

    redirect_to [@post]
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
