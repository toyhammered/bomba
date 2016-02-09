class PendingFriendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: "User"

  validates_presence_of :user_id
  validates_presence_of :friend_id

  validates :user_id, exclusion: { in: ->(pending_friendship) { [pending_friendship.friend_id] } }
  validates_uniqueness_of :user, scope: :friend
  validate :friendship_relationship_does_not_exist

  def accept_friendship
    user.friendships.create(friend: friend)
    destroy
  end

  def deny_friendship
    destroy
  end

  def friendship_relationship_does_not_exist
    if already_friends?
      errors.add(:user, "You are already friends with this user")
    elsif already_pending?
      errors.add(:user, "Whatever you just did... dont do it")
    end
  end

  def already_pending?
    PendingFriendship.find_by(user: friend, friend: user).present?
  end

  def already_friends?
    !user.friendships.build(user_id: user.id, friend_id: friend.id).valid?
  end
end
