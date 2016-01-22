class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.cancel_friendship
    respond_to do |format|
      format.html { redirect_to users_path, notice: "Friendship Deleted" }
    end
  end


end
