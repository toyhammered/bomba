class Api::V1::PostsController < Api::V1::ApiController
  # before_action :authenticated?

  def index
    posts = Post.where(user_id: params[:user_id])
    render json: posts
  end
end
