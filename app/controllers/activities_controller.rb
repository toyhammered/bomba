class ActivitiesController < ApplicationController
  before_action :authenticate_user!

  def index
    @active_friends = current_user.active_friends.includes(:posts)
    @activities = Activity.first(5)
  end
end
