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

  def update
    @post = Post.find(params[:id])
    @post.assign_attributes(post_params)

    authorize @post

    if @post.save
      flash[:notice] = "Post was updated"
    else
      flash[:error] = "There was an error updating the post. Please try again."
    end

    redirect_to user_path(current_user.username)

  end

  def destroy
    @post = Post.find(params[:id])
    authorize @post

    if @post.destroy
      flash[:notice] = "Post was successfully deleted."
    else
      flash[:error] = "There was an error deleting the post"
    end

    redirect_to user_path(current_user.username)

  end

  private

  def post_params
    params.require(:post).permit(:body)
  end

end
