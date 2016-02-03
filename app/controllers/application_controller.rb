class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def track_activity(trackable, action = params[:action])
    Activity.track(current_user, trackable, action)
  rescue
    logger.debug("*****DEBUG*****")
    logger.debug("ApplicationController#track_activity:9, incorrect option passed")
    logger.debug("Trackable: #{trackable.inspect}, Action: #{action}")
  end # end track_activity

end # end ApplicationController
