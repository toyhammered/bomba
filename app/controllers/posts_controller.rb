class PostsController < ApplicationController
  before_action :authenticate_user!

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
  end

end
