class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: "User"
  has_many :activities, as: :trackable, dependent: :destroy

  validates_presence_of :user_id
  validates_presence_of :friend_id

  validates :user_id, exclusion: { in: ->(friendship) { [friendship.friend_id] } }
  validates_uniqueness_of :user, scope: :friend
  validate :inverse_friendship_relationship_does_not_exist

  def cancel_friendship
    self.destroy
  end

  def inverse_friendship_relationship_does_not_exist
    if Friendship.find_by(user: self.friend, friend: self.user).present?
      # adding errors to the model
      errors.add(:user, "inverse friendship relationship already exists")
    end
  end

end
