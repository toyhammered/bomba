class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @requests_from = current_user.pending_friend_requests_from
    @friends = current_user.active_friends

  end

  # Timeline
  def show
    @user = User.find_by(username: params[:id])
    @page = params[:page]
    @posts = @user.posts.includes(:votes, comments: [:votes])
    @friends = @user.active_friends # .includes(posts: [:votes, :comments])

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
    @user.assign_attributes(params.fetch(:user, {}).permit(:avatar))
    authorize @user, :update?

    if params[:user].nil?
      flash[:error] = "You must chose a file."
    elsif @user.save
      flash[:notice] = "Profile Picture Updated"
    else
      flash[:error] = "Please choose a valid file to upload"
    end

    redirect_to user_path(@user.username)
  end


end
