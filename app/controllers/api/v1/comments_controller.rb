class Api::V1::CommentsController < Api::V1::ApiController

  def create
    post = Post.find(params[:post_id])
    comment = post.comments.new(comment_params)
    comment.user_id = current_user.id

    if comment.save
      track_activity(comment)
      render json: comment, current_user: current_user
    else
      render json: comment.errors
    end

  end

  def destroy
  end

  def upvote
    comment = Comment.find(params[:id])
    comment.liked_by current_user
    vote = ActsAsVotable::Vote.find_by(votable_id: comment.id, votable_type: "Comment")
    track_activity(vote)
    redirect_to :back
  end

  def downvote
    comment = Comment.find(params[:id])
    comment.disliked_by current_user
    vote = ActsAsVotable::Vote.find_by(votable_id: comment.id, votable_type: "Comment")
    track_activity(vote)
    redirect_to :back
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
