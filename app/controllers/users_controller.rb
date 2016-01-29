class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @requests_from = current_user.pending_friend_requests_from
    @friends = current_user.active_friends
  end

  # Timeline
  def show
    @user = User.find_by(username: params[:id])
    @posts = Post.where(user_id: @user)
    @friends = @user.active_friends
  end

  # About
  def about
    @user = User.find_by(username: params[:id])
    @posts = Post.where(user_id: @user)
    @friends = @user.active_friends
  end

  # change to avatar
  def avatar
    @user = User.find(params[:id])
    @user.assign_attributes(user_params)

    authorize @user, :update?

    if @user.save
      flash[:notice] = "Profile Picture Updated"
    else
      flash[:error] = "There was an error updating your picture. Please try again."
    end

    redirect_to user_path(@user.username)
  end

  private

  def user_params
    params.require(:user).permit(:avatar)
  end


end
