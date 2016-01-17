class User < ActiveRecord::Base

  enum role: [:standard, :admin]

  after_initialize :set_default_role, :if => :new_record?

  devise :database_authenticatable, :registerable,
         :confirmable, :recoverable, :rememberable,
         :trackable, :validatable

  validates_presence_of :username
  validates_uniqueness_of :username

  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id", dependent: :destroy



  def set_default_role
    self.role ||= :standard
  end

  def request_friendship(user_2)
    self.friendships.create(friend: user_2)
  end

  def pending_friend_requests_from
    self.inverse_friendships.pending
  end

  def pending_friend_requests_to
    self.friendships.pending
  end

  def active_friends
    # we want all of the friendships that we are a friend to them
    # this gets us both user_id and friend_id (which makes up a friendship)
    self.friendships.active.map(&:friend) + self.inverse_friendships.active.map(&:user)
  end

end
