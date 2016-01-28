class User < ActiveRecord::Base
  acts_as_voter

  enum role: [:standard, :admin]

  devise :database_authenticatable, :registerable,
         :confirmable, :recoverable, :rememberable,
         :trackable, :validatable

  USERNAME_REGEX = /\A[a-zA-Z0-9\-_]+\z/i
  validates :username,
    presence: true,
    uniqueness: { case_sensitive: false },
    length: { minimum: 3, maximum: 20 },
    format: { with: USERNAME_REGEX }

  # check why this doesn't work
  # validates :avatar, presence: true

  has_many :pending_friendships, dependent: :destroy
  has_many :inverse_pending_friendships, class_name: "PendingFriendship", foreign_key: "friend_id", dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id", dependent: :destroy

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  # Avatar uploader using carrierwave
  mount_uploader :avatar, AvatarUploader
  after_commit :remove_previously_stored_avatar, on: :update

  # scope :active_friends, -> { joins(:friendships).where.active('friendships.user_id = ? OR friendships.friend_id = ?', self.id, self.id) }
  # scope :pending_friends, -> { joins(:pending_friendships).where.active('friendships.user_id = ? OR friendships.friend_id = ?', self.id, self.id) }

  def owns?(post)
    id == post.user_id
  end

  def request_friendship(user_2)
    pending_friendships.create(friend: user_2)
  end

  def pending_friend_requests_from
    inverse_pending_friendships
  end

  def pending_friend_requests_to
    pending_friendships
  end

  def active_friends
    User.joins(:friendships).where('friendships.user_id = ? OR friendships.friend_id = ?', self.id, self.id)
  end

  def friendship_status(user_2)
    friendships = Friendship.active_for(self)
    pending_friendships = PendingFriendship.pending_for(self)

    return ["not_friends"] if friendships.empty? && pending_friendships.empty?
    return ["friends", friendships] if friendships.present?
    return pending_friendships.take && pending_friendships.take.user == self ?  ["pending", pending_friendships] :  ["requested", pending_friendships]
  end


end
