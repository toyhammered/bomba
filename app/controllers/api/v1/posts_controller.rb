class Api::V1::PostsController < Api::V1::ApiController
  # before_action :authenticated?

  def index
    page = params[:page].present? ? params[:page] : 1
    posts = Post.where(user_id: params[:user_id]).page(page).per(3)

    render json: posts, current_user: current_user
  end

  def show
    posts = Post.where(id: params[:id])
    render json: posts
  end
end
