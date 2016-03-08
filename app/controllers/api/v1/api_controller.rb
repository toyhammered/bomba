class Api::V1::ApiController < ActionController::Base
  include Pundit
  skip_before_action :verify_authenticity_token

  private

  def track_activity(trackable, action = params[:action])
    Activity.track(current_user, trackable, action)
  rescue
    logger.debug("*****DEBUG*****")
    logger.debug("API::V1::ApiController#track_activity:9, incorrect option passed")
    logger.debug("Trackable: #{trackable.inspect}, Action: #{action}")
  end # end track_activity

  # def authenticated?
  #   authenticate_or_request_with_http_basic do |username, password|
  #     resource = User.find_by(username: username)
  #     if resource.valid_password?(password)
  #       sign_in :user, resource
  #     end
  #   end
  # end

end
