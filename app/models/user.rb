class User < ActiveRecord::Base

  enum role: [:standard, :admin]

  # after_initialize :set_default_role, :if => :new_record?

  devise :database_authenticatable, :registerable,
         :confirmable, :recoverable, :rememberable,
         :trackable, :validatable

  USERNAME_REGEX = /\A[a-zA-Z0-9\-_]+\z/i
  validates :username,
    presence: true,
    uniqueness: { case_sensitive: false },
    length: { minimum: 3, maximum: 20 },
    format: { with: USERNAME_REGEX }

  has_many :pending_friendships, dependent: :destroy
  has_many :pending_friendships, dependent: :destroy
  has_many :inverse_pending_friendships, class_name: "PendingFriendship", foreign_key: "friend_id", dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id", dependent: :destroy

  def request_friendship(user_2)
    self.pending_friendships.create(friend: user_2)
  end

  # This is friend request that has been sent to you
  def pending_friend_requests_from
    self.inverse_pending_friendships
  end

  # You have sent a friend request to someone else.
  def pending_friend_requests_to
    self.pending_friendships
  end

  def active_friends
    # we want all of the friendships that we are a friend to them
    # this gets us both user_id and friend_id (which makes up a friendship)
    #self.friendships.active.map(&:friend) + self.inverse_friendships.active.map(&:user)
    self.friendships.map(&:friend) + self.inverse_friendships.map(&:user)
  end

  def friendship_status(user_2)
    # not sure if I am going to need this still
    friendship = Friendship.find_by(user_id: [self.id, user_2.id], friend_id: [self.id, user_2.id])
    pending_friendship = PendingFriendship.find_by(user_id: [self.id, user_2.id], friend_id: [self.id, user_2.id])

    return ["not_friends"] if friendship.nil? && pending_friendship.nil?
    return ["friends", friendship] if friendship.present?
    return pending_friendship.user == self ?  ["pending", pending_friendship] :  ["requested", pending_friendship]
  end

end
