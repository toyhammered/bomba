class Post < ActiveRecord::Base
  acts_as_votable

  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :body, presence: true
  validates :user, presence: true

  def score
    upvote.count - downvotes.count
  end
end
