class Api::V1::PostsController < Api::V1::ApiController

  def index
    page = params[:page].present? ? params[:page] : 1
    # posts = Post.where(user_id: params[:user_id]).page(page).per(3)
    posts = Post.where(user_id: params[:user_id])
    # puts current_user
    render json: posts #, current_user: current_user
  end

  # def show
  #   # this is wrong (well kinda)
  #   posts = Post.where(id: params[:id])
  #   render json: posts, current_user: current_user
  # end

  def create
    post = Post.new(post_params)
    current_user = User.find(params[:current_user])
    post.user_id = current_user.id

    if post.save
      track_activity(current_user, post)
      render json: post # current_user: current_user
    else
      render json: post.errors
    end
  end

  def update
    post = Post.find(params[:id])
    post.assign_attributes(post_params)
    authorize post

    if post.save
      track_activity(post)
      flash[:notice] = "Post was updated"
    else
      flash[:error] = "There was an error updating the post. Please try again."
    end
    redirect_to :back
  end

  def destroy
    post = Post.find(params[:id])
    # authorize post

    if post.destroy
      render json: post
    else
      render json: post.errors
    end
  end

  def upvote
    post = Post.find(params[:post_id])
    current_user = User.find(params[:current_user_id])

    post.liked_by current_user
    vote = ActsAsVotable::Vote.find_by(votable_id: post.id, votable_type: "Post")
    track_activity(current_user, vote)
    render json: vote
  end

  def downvote
    post = Post.find(params[:post_id])
    current_user = User.find(params[:current_user_id])

    post.disliked_by current_user
    vote = ActsAsVotable::Vote.find_by(votable_id: post.id, votable_type: "Post")

    track_activity(current_user, vote)
    render json: vote
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end

end
