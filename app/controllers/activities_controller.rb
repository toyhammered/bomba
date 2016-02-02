class ActivitiesController < ApplicationController
  def index
    @active_friends = current_user.active_friends.includes(:posts)
  end
end
