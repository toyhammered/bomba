class Api::V1::PostsController < Api::V1::ApiController
  # before_action :authenticated?

  def index
    page = params[:page].present? ? params[:page] : 1
    # posts = Post.where(user_id: params[:user_id]).page(page).per(3)
    posts = Post.where(user_id: params[:user_id])

    render json: posts, current_user: current_user
  end

  def show
    # this is wrong
    posts = Post.where(id: params[:id])
    render json: posts
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id

    if post.save
      track_activity(post)

    else
      render json: post.errors.to_json
    end
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end

end
