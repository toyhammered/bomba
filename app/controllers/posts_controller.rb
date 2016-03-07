class PostsController < ApplicationController
  before_action :authenticate_user!

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
  end

  def update
    @post = Post.find(params[:id])
    @post.assign_attributes(post_params)

    authorize @post

    if @post.save
      track_activity(@post)
      flash[:notice] = "Post was updated"
    else
      flash[:error] = "There was an error updating the post. Please try again."
    end

    redirect_to :back

  end

  def destroy
    @post = Post.find(params[:id])
    authorize @post

    if @post.destroy
      flash[:notice] = "Post was successfully deleted."
    else
      flash[:error] = "There was an error deleting the post"
    end

    redirect_to "/users/" + current_user.username
  end

  def upvote
    @post = Post.find(params[:id])
    @post.liked_by current_user
    @vote = ActsAsVotable::Vote.find_by(votable_id: @post.id, votable_type: "Post")
    track_activity(@vote)
    redirect_to :back
  end

  def downvote
    @post = Post.find(params[:id])
    @post.disliked_by current_user
    @vote = ActsAsVotable::Vote.find_by(votable_id: @post.id, votable_type: "Post")
    track_activity(@vote)
    redirect_to :back
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end

end
