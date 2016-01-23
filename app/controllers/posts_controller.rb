class PostsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      flash[:notice] = "Post was created"
    else
      flash[:error] = "Error creating Post. Please try again."
    end
    redirect_to user_path(current_user.username)
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end

end
