class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @friend = User.find(params[:user_id])
    @freindship = current_user.request_friendship(@friend)
    # raise
    respond_to do |format|
      format.html {redirect_to users_path, notice: "Friendship Created"}
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    respond_to do |format|
      format.html {redirect_to users_path, notice: "Friendship Deleted"}
    end
  end

  def accept
    @friendship = Friendship.find(params[:id])
    @friendship.accept_friendship
    respond_to do |format|
      format.html {redirect_to users_path, notice: "Friendship Accepted"}
    end
  end

end
