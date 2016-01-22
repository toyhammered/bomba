class PendingFriendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: "User"

  validates_presence_of :user_id
  validates_presence_of :friend_id

  validates :user_id, exclusion: { in: ->(pending_friendship) { [pending_friendship.friend_id] } }
  validates_uniqueness_of :user, scope: :friend
  validate :inverse_pending_friendship_relationship_does_not_exist

  def accept_friendship
    self.user.friendships.create(friend: self.friend)
    self.destroy
  end

  def deny_friendship
    self.destroy
  end

  def inverse_pending_friendship_relationship_does_not_exist
    if (PendingFriendship.find_by(user: self.friend, friend: self.user).present?
      # adding errors to the model
      errors.add(:user, "inverse pending friendship relationship already exists")
    end
  end
end
