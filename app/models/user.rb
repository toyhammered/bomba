class User < ActiveRecord::Base

  enum role: [:standard, :admin]
  after_initialize :set_default_role, :if => :new_record?

  devise :database_authenticatable, :registerable,
         :confirmable, :recoverable, :rememberable,
         :trackable, :validatable

  validates_presence_of :username
  validates_uniqueness_of :username

  def set_default_role
    self.role ||= :standard
  end

  def request_friendship(user_2)
    self.friendships.create(friend: user_2)
  end

end
