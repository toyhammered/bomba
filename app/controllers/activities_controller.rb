class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @active_friends = current_user.active_friends.includes(:posts)
  end
end
