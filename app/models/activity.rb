class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :trackable, polymorphic: true
  default_scope { order(created_at: :desc)}

  def self.track(user, trackable, action)
    case action
    when "create"
      user.activities.create!(action: action, trackable: trackable)
    when "update"
      user.activities.find_or_create_by!(action: action, trackable: trackable, trackable_type: trackable.class) do |activity|
        activity.update_attributes(updated_at: Time.now)
      end
    when "accept"
      user = User.find(trackable.user_id)
      friend = User.find(trackable.friend_id)

      user.activities.create!(action: action, trackable: trackable)
      friend.activities.create!(action: action, trackable: trackable)
    when "downvote", "upvote"
      user.activities.find_or_create_by!(action: action, trackable_id: trackable.id, trackable_type: ActsAsVotable::Vote) do |activity|
        activity.update_attributes(updated_at: Time.now)
      end
    else
      raise "Unable to track action."
    end
  end

end
