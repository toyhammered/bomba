class UsersController < ApplicationController
  def index
    @requests_from = current_user.pending_friend_requests_from.map(&:user)
    @friends = current_user.active_friends
  end

  def show
    @user = User.find_by(username: params[:id])
  end
end
