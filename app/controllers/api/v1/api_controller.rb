class Api::V1::ApiController < ActionController::Base
  include Pundit
  skip_before_action :verify_authenticity_token

  private

  def track_activity(current_user, trackable, action = params[:action])
    Activity.track(current_user, trackable, action)
  rescue
    logger.debug("*****DEBUG*****")
    logger.debug("API::V1::ApiController#track_activity:9, incorrect option passed")
    logger.debug("Trackable: #{trackable.inspect}, Action: #{action}")
  end # end track_activity

end
