class PostsController < ApplicationController
  before_action :authenticate_user!

  def show
    @post = []
    post = Post.find(params[:id])
    @post.push(post)
    @user = User.find(post.user_id)
  end

end
