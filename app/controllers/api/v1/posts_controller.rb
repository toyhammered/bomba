class Api::V1::PostsController < Api::V1::ApiController
  # before_action :authenticated?

  def index
    posts = Post.where(user_id: params[:user_id])
    render json: posts
  end

  def show
    posts = Post.where(id: params[:id])
    puts posts.inspect
    render json: posts
  end
end
