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

  has_many :activities, dependent: :destroy
  has_many :pending_friendships, dependent: :destroy
  has_many :friendships, dependent: :destroy

  has_many :posts, through: :activities, source: :trackable, source_type: :Post, dependent: :destroy

  has_many :comments, dependent: :destroy

  # Avatar uploader using carrierwave
  mount_uploader :avatar, AvatarUploader
  after_commit :remove_previously_stored_avatar, on: :update

  def request_friendship(user_2)
    pending_friendships.create(friend: user_2)
  end

  def pending_friend_requests_from
    User.joins('INNER JOIN pending_friendships ON pending_friendships.user_id = users.id').where('pending_friendships.friend_id = ?', self.id)
  end

  def active_friends
    User.joins('INNER JOIN friendships ON friendships.friend_id = users.id').
         where('friendships.user_id = ?', self.id).
         union(User.joins(:friendships).
                    where('friendships.friend_id = ?', self.id)).
         includes(posts: [:votes, :comments])
  end
end
