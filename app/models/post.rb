class Post < ActiveRecord::Base
  acts_as_votable
  default_scope { order(created_at: :desc)}

  belongs_to :user

  has_many :activities, as: :trackable, dependent: :destroy

  has_many :comments, dependent: :destroy

  validates :body, presence: true
  validates :user, presence: true

end
