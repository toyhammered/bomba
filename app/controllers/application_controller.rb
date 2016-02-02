class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def track_activity(trackable, action = params[:action])
    case action
    when "create"
      current_user.activities.create!(action: action, trackable: trackable)
    when "update"
      current_user.activities.find_or_create_by(action: action, trackable: trackable, trackable_type: trackable.class) do |activity|
        activity.update_attributes(created_at: Time.now)
      end
    when "destroy"
      current_user.activities.where(trackable: trackable, trackable_type: trackable.class).delete_all
    else
      raise "WUT? This should not have happened"
    end
  end # end track_activity

end # end ApplicationController
