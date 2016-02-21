class Api::V1::ApiController < ActionController::Base
  skip_before_action :verify_authenticity_token

  private

  # def authenticated?
  #   authenticate_or_request_with_http_basic do |username, password|
  #     resource = User.find_by(username: username)
  #     if resource.valid_password?(password)
  #       sign_in :user, resource
  #     end
  #   end
  # end

end
