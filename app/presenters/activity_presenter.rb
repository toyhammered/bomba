class ActivityPresenter < SimpleDelegator
  attr_reader :activity
  def initialize(activity, view)
    super(view)
    @activity = activity
  end

  def render_activity
    link_to(activity.user.username, user_path(activity.user.username)) + " " +
    render_partial
  end

  def render_partial
    locals = {activity: activity, presenter: self}
    locals[activity.trackable_type.underscore.to_sym] = activity.trackable
    render partial: partial_path, locals: locals
  end

  def partial_path
    "activities/#{activity.trackable_type.underscore}/#{activity.action}"
  end
end
