class Comment < ActiveRecord::Base
  acts_as_votable
  default_scope { includes(:votes).order(created_at: :desc)}

  belongs_to :post
  belongs_to :user

  has_many :activities, as: :trackable, dependent: :destroy
  has_many :votes, as: :votable, class_name: "ActsAsVotable::Vote"

  validates :body, presence: true
  validates :post, presence: true
  validates :user, presence: true

  def up_votes
    get_likes.size
  end

  def down_votes
    get_dislikes.size
  end

  def total_votes
    (up_votes - down_votes)
  end
end
