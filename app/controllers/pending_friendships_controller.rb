class PendingFriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @friend = User.find(params[:user_id])
    @pending_freindship = current_user.request_friendship(@friend)
    respond_to do |format|
      format.html {redirect_to :back, notice: "Friendship Request Sent"}
    end
  end

  def destroy
    @pending_friendship = PendingFriendship.find(params[:id])
    @pending_friendship.destroy
    respond_to do |format|
      format.html {redirect_to :back, notice: "Friend Request Canceled"}
    end
  end

  def accept
    @pending_friendship = PendingFriendship.find(params[:id])
    @pending_friendship.accept_friendship
    @friendship = Friendship.find_by(user_id: @pending_friendship.user_id, friend_id: @pending_friendship.friend_id)
    track_activity(current_user, @friendship)

    respond_to do |format|
      format.html { redirect_to :back, notice: "Friendship Accepted" }
    end
  end
end
