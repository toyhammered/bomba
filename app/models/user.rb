class User < ActiveRecord::Base

  enum role: [:standard, :admin]

  after_initialize :set_default_role, :if => :new_record?

  devise :database_authenticatable, :registerable,
         :confirmable, :recoverable, :rememberable,
         :trackable, :validatable

  USERNAME_REGEX = /\A[a-zA-Z0-9\-_]+\z/i
  validates :username,
    presence: true,
    uniqueness: { case_sensitive: false },
    length: { minimum: 3, maximum: 20 },
    format: { with: USERNAME_REGEX }

  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id", dependent: :destroy


  def set_default_role
    self.role ||= :standard
  end

  def request_friendship(user_2)
    # return if self == user_2
    self.friendships.create(friend: user_2)
  end

  # This is friend request that has been sent to you
  def pending_friend_requests_from
    self.inverse_friendships.pending
  end

  # You have sent a friend request to someone else.
  def pending_friend_requests_to
    self.friendships.pending
  end

  def active_friends
    # we want all of the friendships that we are a friend to them
    # this gets us both user_id and friend_id (which makes up a friendship)
    self.friendships.active.map(&:friend) + self.inverse_friendships.active.map(&:user)
  end

  def friendship_status(user_2)
    friendship = Friendship.find_by(user_id: [self.id, user_2.id], friend_id: [self.id, user_2.id])

    return "not_friends" if friendship.nil?
    return "friends" if friendship.active?
    return friendship.user == self ?  "pending" :  "requested"
  end

  def friendship_relation(user_2)
    Friendship.find_by(user_id: [self.id, user_2.id], friend_id: [self.id, user_2.id])
  end

end
